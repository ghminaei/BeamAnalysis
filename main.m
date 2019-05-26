function main(filename)

    global mainMatrixC;
    global mainMatrixB;
    global mainMatrixA;
    global howManyJoints;
    global howManyElement;
    %C*B=A
    [myJoint,myElement,startJoint,endJoint,flagStable]=inputFunc(filename);
    if flagStable==0
        return
    end
    mainMatrixC=zeros(12*howManyJoints+3*howManyElement);
    mainMatrixA=zeros(12*howManyJoints+3*howManyElement,1);
    mainMatrixB=zeros(12*howManyJoints+3*howManyElement,1);
  
    equtations(myJoint,myElement,startJoint,endJoint)
    
    if det(mainMatrixC)==0
        %fprintf('This is not Stable!\n');
        
        fileName='outPut.txt';
        fid=fopen(fileName,'wt');
        fprintf(fid,'The structure is not Stable!\n');
    
        return
    else
        mainMatrixB=inv(mainMatrixC)*mainMatrixA;
    end
    myJoint=outPut(myElement,myJoint);
    
    internalForces(myElement,myJoint)
end
