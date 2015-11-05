function classes = classify(test,train,labels, classifier_parameters)
% disp('Classify')
classifier = create_classifier(train, labels, classifier_parameters);
classes = classifier(test);

end