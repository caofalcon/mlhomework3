%% loading images

clc; clear;

rootFolder = fullfile('C:\Users\R\Projects\mlhomework3\train_sorted');
categories = {'1', '2', '3','4', '5', '6', '7', '8'};

imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');

[testDigitData, trainDigitData] = splitEachLabel(imds,...
				3,'randomize');

%%
% %% balancing classes 
% tbl = countEachLabel(imds);
% 
% minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category
% 
% % Use splitEachLabel method to trim the set.
% imds = splitEachLabel(imds, minSetCount, 'randomize');
% 
% % Notice that each set now has exactly the same number of images.
% countEachLabel(imds)
% 
% 
% %% Find the first instance of an image for each category
% structures = find(imds.Labels == '1', 1);
% indoors = find(imds.Labels == '2', 1);
% people = find(imds.Labels == '3', 1);
% animals = find(imds.Labels == '4', 1);
% plants = find(imds.Labels == '5', 1);
% food = find(imds.Labels == '6', 1);
% cars = find(imds.Labels == '7', 1);
% sea = find(imds.Labels == '8', 1);
% 
% figure
% subplot(4,2,1);
% imshow(readimage(imds,structures))
% subplot(4,2,2);
% imshow(readimage(imds,indoors))
% subplot(4,2,3);
% imshow(readimage(imds,people))

%% 
layers = [imageInputLayer([128 128 3]);
          convolution2dLayer(7, 96, 'Padding', 2, 'Stride',2);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          
          convolution2dLayer(4, 256, 'Padding',1, 'Stride',1);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          
          convolution2dLayer(2, 384, 'Padding',1, 'Stride',1);
      
          convolution2dLayer(2, 256, 'Padding',1, 'Stride',1);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          
          fullyConnectedLayer(40);
          reluLayer();
          fullyConnectedLayer(40);
          reluLayer();
          fullyConnectedLayer(8);
          softmaxLayer();
          classificationLayer()];
      
options = trainingOptions('sgdm','MaxEpochs',20,...
	'InitialLearnRate',0.001);

convnet = trainNetwork(trainDigitData,layers,options);

YTest = classify(convnet,testDigitData);
TTest = testDigitData.Labels;

accuracy = sum(YTest == TTest)/numel(TTest)

