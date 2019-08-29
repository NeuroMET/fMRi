function fmc2_2_realign_txt2graph(data_path, subject)

%% Create graphes and pictures of motion parameters after fMRI-EPI Realignment

   %% Example:
   % fmc2_2_realign_txt2graph('/my/input/path', 'sub001')
   in_path = strcat(data_path, '/', subject, '/bold/3D_bold');
   out_path = strcat(data_path, '/', subject);
   filt = ['^rp_*','.*\.txt$'];
   b = spm_select('FPList', in_path, filt);
   % Choose min max of y-scale
   scaleme = [-3 3];
   out_dir = out_path;

   for i = 1:size(b,1)

     [p nm e v] = spm_fileparts(b(i,:));
     printfig = figure;
     set(printfig, 'Name', ['Motion parameters - ' subject ], 'Visible', 'on');
     loadmot = load(deblank(b(i,:)));
     subplot(2,1,1);
     plot(loadmot(:,1:3));
     grid on;
     ylim(scaleme);  % enable to always scale between fixed values as set above
     title(['Translation - '  subject], 'interpreter', 'none');
     ylabel('mm');
     xlabel('image');
     legend('x traslation','y traslation', 'z traslation','Location','southwest')
     subplot(2,1,2);
     plot(loadmot(:,4:6)*180/pi);
     grid on;
     ylim(scaleme);   % enable to always scale between fixed values as set above
     title(['Rotation - '  subject], 'interpreter', 'none');
     ylabel('degrees');
     xlabel('image');
     legend('pitch','roll', 'yaw', 'Location','southwest');
     pdf_name = [out_dir filesep subject 'Realign_Estimate.png'];
     print(printfig, '-dpng', '-noui', '-r100', pdf_name);  % enable to print to file
     close(printfig);   % enable to close graphic window
   end;
end
