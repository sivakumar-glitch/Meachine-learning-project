clc
clear all
close all
warning off all
system_dependent('DirChangeHandleWarn','never');
addpath(genpath('.'));
drugnames={'Phenytoin ','Carbamazepine ','SodiumValproate ','phenobartone ',...
   'Clobazam ','Levetiracetam ','Phenobarbitone ','folvite ','Carbomaizine ','Lamotrigine '};
tic
[~,~,data]=xlsread('dataset1.xlsx','Sheet2','T:T','%d');
dru_name1=data(:,1);
% out=[];
% h=waitbar(0,'process...');
% for i=3:length(dru_name1)
% waitbar(i/length(dru_name1))
% dru=dru_name1(i,:);
% dru_name=dru{:};
% out=vertcat(out,dru_name); 
% end
% close(h)
% time=toc
load('drug_name.mat')
load('out.mat')
out1=out;
for i=1:length(out)
  a=out1(i,:);  
  a1=isnan(a);
  if a1==0
  a2=a;
  end
  if a1==1
  out1(i,:)=a2;
  end
end
data=[age];
for i1=1:inf
[C, I, iter] = Kmeans(data,2);
ch=I(end,:);
data1=[drug_name,out1];
fit=[];
ab=[];
for i=1:10
 data2=data1(:,1);
 a=find(data2==i);
 a1=data1(a,:);
 size(a);
[m n]=size(a1);
b=a1(:,2);
b1=find(b==0);
b2=find(b==1);
[m1 n1]=size(b1);
[m2 n2]=size(b2);
perc=(m1/m)*100; 
perc1=(m2/m)*100;
string=drugnames(:,i);
str={'Fit Free percentage is : '};
str1={'Abnormal percentage is : '};
disp(strcat(string,str,num2str(perc))) 
disp(strcat(string,str1,num2str(perc1)))
ab=vertcat(ab,perc1);
fit=vertcat(fit,perc);
end

grpn={'Fit Free','Abnormal'};
 tabfig= figure('name','Comparision table','numbertitle','off','Position',[200 200 850 300]);
            dat = [fit(:) ab(:)];
            uitable('Parent',tabfig,'Data',dat,'ColumnName',grpn,'RowName',drugnames,'ColumnWidth',{100},'Position',[20 20 800 250]);

          fit=fit';  
             fi=[0 0 0 0 0 0 0 0 0 0 ;fit;0 0 0 0 0 0 0 0 0 0];
figure('name','Fit free comparison','numbertitle','off')
bar(fi)
axis([1,3,10,105])
set(gca,'xticklabel',{'','',''})
xlabel('Drugs')
ylabel('Values in %')
legend('Phenytoin ','Carbamazepine ','SodiumValproate ','phenobartone ',...
   'Clobazam ','Levetiracetam ','Phenobarbitone ','folvite ','Carbomaizine ','Lamotrigine ','location','best')

            ab=ab';  
             fi=[0 0 0 0 0 0 0 0 0 0 ;ab;0 0 0 0 0 0 0 0 0 0];
figure('name','Abnornal comparison','numbertitle','off')
bar(fi)
axis([1,3,10,105])
set(gca,'xticklabel',{'','',''})
xlabel('Drugs')
ylabel('Values in %')
legend('Phenytoin ','Carbamazepine ','SodiumValproate ','phenobartone ',...
   'Clobazam ','Levetiracetam ','Phenobarbitone ','folvite ','Carbomaizine ','Lamotrigine ','location','best')

            












