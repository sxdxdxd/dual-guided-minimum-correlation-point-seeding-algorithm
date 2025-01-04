function ConditionalEntropy = calculateGlobalConditionalEntropy2D(BinField, BinField_R, N_Bins, Entropy, Method)
N_x = size(BinField, 2);
N_y = size(BinField, 1);
%% 统计直方图
%% Calculate histogram
Histogram2D = spalloc(N_Bins, N_Bins, ceil(N_Bins / 2));
for Iy = 1:N_y
    for Ix = 1:N_x
        Bin_INDEX1 = BinField(Iy, Ix);
        Bin_INDEX2 = BinField_R(Iy, Ix);
        Histogram2D(Bin_INDEX1, Bin_INDEX2) = Histogram2D(Bin_INDEX1, Bin_INDEX2) + 1;
    end
end
%% 计算联合概率场
%% Calculate the joint probability field
Total_NUM = N_x * N_y;
JointProbabilityDistribution = Histogram2D ./Total_NUM;
%% 计算重建流场的信息熵
%% Calculate the information entropy of the reconstructed flow field
if strcmp(Method,'H(X|Y)')
    Entropy = calculateTotalEntropy2D(BinField_R, N_Bins);
end
%% 计算联合熵场
%% Calculate the joint entropy field
JointEntropy = calculateEntropy(JointProbabilityDistribution);
%% 计算条件熵场
%% Calculate the conditional entropy field
ConditionalEntropy = JointEntropy - Entropy;
end