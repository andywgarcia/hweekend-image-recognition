% Demo macro to extract frames and get frame means from an avi movie
% and save individual frames to separate image files.
% Then rebuilds a new movie by recalling the saved images from disk.
% Also computes the mean gray value of the color channels
% And detects the difference between a frame and the previous frame.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 14;
mfilename = 'ExtractMovieToFrames.m';
% Change the current folder to the folder of this m-file.
% (The line of code below is from Brett Shoelson of The Mathworks.)
if(~isdeployed)
	cd(fileparts(which(mfilename)));
end

% Open the rhino.avi demo movie that ships with MATLAB.
% folder = fullfile(matlabroot, '/toolbox/images/imdemos');
%movieFullFileName = fullfile(folder, 'rhinos.avi');
% movieFullFileName = './videos/IMG_0343.TRIM.m4v';
tic
all = rdir('./videos/*/*');
s = size(all);
for file = 1 : s(1)
    if (all(file).isdir == 1)
        continue;
    end
    movieFullFileName = all(file).name;

    try
        videoObject = VideoReader(movieFullFileName);
        % Determine how many frames there are.
        numberOfFrames = videoObject.NumberOfFrames;
        vidHeight = videoObject.Height;
        vidWidth = videoObject.Width;

        numberOfFramesWritten = 0;

        writeToDisk = true;

        % Extract out the various parts of the filename.
        [folder, baseFileName, extentions] = fileparts(movieFullFileName);
        % Make up a special new output subfolder for all the separate
        % movie frames that we're going to extract and save to disk.
        % (Don't worry - windows can handle forward slashes in the folder name.)
        folder = pwd;   % Make it a subfolder of the folder where this m-file lives.
        outputFolder = sprintf('%s/frames_%s', folder, baseFileName);
        % Create the folder if it doesn't exist already.
        if ~exist(outputFolder, 'dir')
            mkdir(outputFolder);
        end


        % Loop through the movie, writing all frames out.
        % Each frame will be in a separate file with unique name.

        for frame = 1 : numberOfFrames
            % Extract the frame from the movie structure.
            thisFrame = read(videoObject, frame);

            % Write the image array to the output file, if requested.

            % Construct an output image file name.
            outputBaseFileName = sprintf('Frame %4.4d.jpg', frame);
            outputFullFileName = fullfile(outputFolder, outputBaseFileName);

            % Write it out to disk.
            imwrite(thisFrame, outputFullFileName, 'jpg');

            %fprintf('Wrote frame %4d of %d.\n', frame, numberOfFrames);

            % Increment frame count (should eventually = numberOfFrames
            % unless an error happens).
            numberOfFramesWritten = numberOfFramesWritten + 1;


        end

        % Alert user that we're done.
        finishedMessage = sprintf('Done!  It wrote %d frames to folder\n"%s"', numberOfFramesWritten, outputFolder);

        disp(finishedMessage); % Write to command window.

    catch ME
%         Some error happened if you get here.
        strErrorMessage = sprintf('Error extracting movie frames from:\n\n%s\n\nError: %s\n\n)', movieFullFileName, ME.message);
        uiwait(msgbox(strErrorMessage));
    end
end
toc

