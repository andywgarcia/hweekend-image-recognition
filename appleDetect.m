%% Read in images
image_folder = '~/imagerecognition/images';
imds = imageDatastore(image_folder,...
                    'IncludeSubfolders',true,...
                    'LabelSource','foldernames');

%% Parse image information to a table
tbl = countEachLabel(imds);
categories = tbl.Label;

%% Get a sample of each label
sample = splitEachLabel(imds,16);
%montage(sample.Files(1:16));
%title(char(tbl.Label(1)));

%% Parition files into training and testing
[training_set,testing_set] = prepareInputFiles(imds);

%% Create Visual Vocabulary
tic
bag = bagOfFeatures(training_set,...
    'VocabularySize',250,...
    'PointSelection','Detector');
appleData = double(encode(bag,training_set));
toc

%% Visualize Feature Vectors
% img = read(training_set(1), randi(training_set(1).Count));
% featureVector = encode(bag, img);
% 
% subplot(2,2,1); imshow(img);
% subplot(2,2,2); 
% bar(featureVector);
% title('Visual Word Occurrences');
% xlabel('Visual Word Index');
% ylabel('Frequency');
% 
% img = read(training_set(2), randi(training_set(2).Count));
% featureVector = encode(bag, img);
% subplot(2,2,3); imshow(img);
% subplot(2,2,4); 
% bar(featureVector);
% title('Visual Word Occurrences');
% xlabel('Visual Word Index');
% ylabel('Frequency');

%% Create a Table using the encoded features
appleImageData = array2table(appleData);
appleType = categorical(repelem({training_set.Description}', [training_set.Count], 1));
appleImageData.appleType = appleType;

%% Classification Learner
%classificationLearner
[trainedClassifier,validationAccuracy] = trainClassifier(appleImageData);

%% Test
testAppleData = double(encode(bag,testing_set));
testAppleData = array2table(testAppleData,...
                'VariableNames',trainedClassifier.RequiredVariables);
actualAppleType = categorical(repelem({testing_set.Description}',...
                                    [testing_set.Count], 1));

predictedOutcome = trainedClassifier.predictFcn(testAppleData);
correctPredictions = (predictedOutcome == actualAppleType);
validationAccuracy = sum(correctPredictions)/length(predictedOutcome) %#ok

%% Visualize how the classifier works
ii = randi(size(testing_set,2));
jj = randi(testing_set(ii).Count);
img = read(testing_set(ii),jj);

imshow(img)
% Add code here to invoke the trained classifier
imagefeatures = double(encode(bag, img));
% Find two closest matches for each feature
[bestGuess, score] = predict(trainedClassifier.ClassificationKNN,imagefeatures);
% Display the string label for img
if strcmp(char(bestGuess),testing_set(ii).Description)
	titleColor = [0 0.8 0];
else
	titleColor = 'r';
end
title(sprintf('Best Guess: %s; Actual: %s',...
	char(bestGuess),testing_set(ii).Description),...
	'color',titleColor)




