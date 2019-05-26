
function [myJoint,myElement,startJoint,endJoint,flagStable]=inputFunc(fileName)
    flagStable=1;
    excelMatrix = xlsread(fileName);
    global howManyJoints;
    howManyJoints = excelMatrix(1,2);
    
    global howManyElement;
    howManyElement = excelMatrix(1,15);

    findDuplicateInJointsMatrix=xlsread(fileName,'O:P');
    [startJoint,endJoint]=whereIsJoint(findDuplicateInJointsMatrix);
    
    informationForCountOFEqusAndUnksMatrix=xlsread(fileName,'D:I');
    checkstabilityAndDefined=stabilityAndDefined(informationForCountOFEqusAndUnksMatrix);

    if checkstabilityAndDefined==0
        
    
    for i=3:howManyJoints+2
        myJoint(i-2)=Joints;
        myJoint(i-2).number=excelMatrix(i,1);
        myJoint(i-2).x=excelMatrix(i,2);
        myJoint(i-2).y=excelMatrix(i,3);
        myJoint(i-2).isCX=excelMatrix(i,4);
        myJoint(i-2).isCY=excelMatrix(i,5);
        myJoint(i-2).isCT=excelMatrix(i,6);
        myJoint(i-2).isSX=excelMatrix(i,7);
        myJoint(i-2).isSY=excelMatrix(i,8);
        myJoint(i-2).isST=excelMatrix(i,9);
        myJoint(i-2).fX=excelMatrix(i,10);
        myJoint(i-2).fY=excelMatrix(i,11);
        myJoint(i-2).m=excelMatrix(i,12);
        
    end
    

    
    for i=3:howManyElement+2
        myElement(i-2)=Elements;
        myElement(i-2).number=excelMatrix(i,14);
        myElement(i-2).jL=excelMatrix(i,15);
        myElement(i-2).jR=excelMatrix(i,16);
        myElement(i-2).qX=excelMatrix(i,17);
        myElement(i-2).qY=excelMatrix(i,18);
        myElement(i-2).qM=excelMatrix(i,19);
        
        myElement(i-2)=myElement(i-2).calLength(myJoint);
        myElement(i-2)=myElement(i-2).calSinT(myJoint);
        myElement(i-2)=myElement(i-2).calCosT(myJoint);
        

        
    end
    elseif checkstabilityAndDefined==-1
        
        fileName='outPut.txt';
        fid=fopen(fileName,'wt');
        fprintf(fid,'The structure is indeterminate!\n');
        flagStable=0;
        myJoint=0;
        myElement=0;
        startJoint=0;
        endJoint=0;
        
        
    else
        fileName='outPut.txt';
        fid=fopen(fileName,'wt');
        fprintf(fid,'The structure is not Stable!\n');
        flagStable=0;
        myJoint=0;
        myElement=0;
        startJoint=0;
        endJoint=0;
        
    end
    
end

function [sumLeft,sumRight]=whereIsJoint(findDuplicateInJointsMatrix)
    findDuplicateInJointsMatrix(1,:)=[];
    findDuplicateInJointsMatrix(1,:)=[];
    global howManyElement;
    for i=1:howManyElement
        a=findDuplicateInJointsMatrix(i,1);
        for j=1:howManyElement
            if a==findDuplicateInJointsMatrix(j,2)
                findDuplicateInJointsMatrix(i,1)=0;
                findDuplicateInJointsMatrix(j,2)=0;
            end
        end
        
    end
    sumRight=sum(findDuplicateInJointsMatrix(:,2));
    sumLeft=sum(findDuplicateInJointsMatrix(:,1));    
end

function res=stabilityAndDefined(infoMatrix)
    countOfUnknowns=0;
    countOfElsMinusOne=0;
    global howManyJoints;
    
    for i=1:howManyJoints
        flag=0;
        numberOfZeros=0;
        for j=1:3
            
            if infoMatrix(i,j)==0
                numberOfZeros=numberOfZeros+1;
                
                flag=1;
            end
        end
        
        if flag==1
            countOfElsMinusOne=countOfElsMinusOne+1;
            countOfUnknowns=countOfUnknowns+(3-numberOfZeros);
        end
        %flag=0;
        for j=4:6
            if infoMatrix(i,j)==1
                countOfUnknowns=countOfUnknowns+1;
                %flag=1;
            end
        end
        
        %if flag==1
        %    countOfElsPlusOne=countOfElsPlusOne+1;
        %end
    end
                
             
                
    countOfEqus=(countOfElsMinusOne+1)*3;
    
    
    if countOfEqus==countOfUnknowns
        res=0; %defined
    elseif countOfEqus<=countOfUnknowns
        res=-1; %undefined
    else
        res=1; %unstable
    end

end