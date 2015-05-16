# TFI Restaurant Revenue Prediction
This is a sample MATLAB solution for TFI Restaurant Revenue Prediction challenge:
https://www.kaggle.com/c/restaurant-revenue-prediction.

The solution yields a score of 1842944.03992 on the public leaderboard, and 1819379.68807 on the private one. Final ranking was 399.

This solution uses an ensemble of Random forests. In each iteration, the training data rows are shuffled, and the variables P1-P37 are assigned a categorical label in a random fashion (due to lack of knowledge about these variables until soon before the competition deadline). 

## Instructions:

1. MATLAB and Statistics and Machine Learning Toolbox are required.
2. Download data from competition website and place them into the same folder.
3. Run Random_forest.m

