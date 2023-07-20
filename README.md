### End-To-End-Credit-Risk-Analysis
Credit risk is the risk of a borrow defaulting on a debt and that the lender may lose the principal of the loan or associated interest. When a bank receives a loan application, it has to make a decision as to whether to approve the loan or not based on the applicant’s profile. If the bank deems the applicant to have bad credit risk, it means the applicant is not likely to repay the loan and approving the loan could result in financial loss to the bank.

The purpose of this project is to take a data set of loan applications and build a predictive model for making a decision as to whether to approve a loan based on the applicant’s profile. An application will then be built which is intended to provide guidance to a bank manager for making this decision.

### Data
The data for the analysis is a set of 1000 German credit applications with 20 different attributes of the applicant. The original data is from the UCI Machine Learning Repository but the CSV version used in this analysis can be found from the Penn State University website (https://onlinecourses.science.psu.edu/stat857/node/215). Further information about the data set can be found at:

https://archive.ics.uci.edu/ml/datasets/statlog+(german+credit+data)

### A screenshot of the final application

![CRA](https://github.com/SiddharthUchil/End-To-End-Credit-Risk-Analysis/assets/36127139/a3bb7744-c76d-4236-b5a9-75a69477ec3a)


### Conclusion
It shows a way in which a bank manager could use the application to guide decision making on credit applications. Although the application is quite basic, it gives an indication as to how value can be extracted from analysing data.

One limitation of the analysis is the fairly small and historic data used in this example. A good model would draw on thousands (if not millions) of customers data and be constantly adapting to the flow of information. However this was not possible in the example due to access to relevant data and computational limits.

Furthermore, more complicated models could certainly be developed to produce more accurate predictions. This example aims to show that fairly accurate models can be produced using only a few lines of code and well known statistical modeling methods.
