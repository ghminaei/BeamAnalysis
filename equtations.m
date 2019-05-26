function equtations(myJoint,myElement,startJoint,endJoint)
    global howManyJoints;
    global howManyElement;
    whichRow=1;
    
    for i=1:howManyJoints
        whichRow=jointEqu(i,whichRow);
    end
    for i=1:howManyElement
        whichRow=elementEqu(i,whichRow,myElement);
    end
    whichRow=zeroEqu(whichRow,myJoint,myElement,startJoint,endJoint);
end

function whichRow=jointEqu(numberOfJoint,whichRow)
    global mainMatrixC;
    
    jMatrix=(numberOfJoint-1)*12;
    
    mainMatrixC(whichRow,jMatrix+2)=-1;
    mainMatrixC(whichRow,jMatrix+5)=1;
    mainMatrixC(whichRow,jMatrix+7)=1;
    mainMatrixC(whichRow,jMatrix+10)=1;
    
    
    whichRow=whichRow+1;
    
    mainMatrixC(whichRow,jMatrix+1)=1;
    mainMatrixC(whichRow,jMatrix+4)=-1;
    mainMatrixC(whichRow,jMatrix+8)=1;
    mainMatrixC(whichRow,jMatrix+11)=1;
    
    whichRow=whichRow+1;
    
    mainMatrixC(whichRow,jMatrix+3)=-1;
    mainMatrixC(whichRow,jMatrix+6)=1;
    mainMatrixC(whichRow,jMatrix+9)=1;
    mainMatrixC(whichRow,jMatrix+12)=1;
    
    whichRow=whichRow+1;
end

function whichRow=elementEqu(numberOfElements,whichRow,myElement)
    global mainMatrixC;
    global howManyJoints

    jMatrix=howManyJoints*12+(numberOfElements-1)*3;
    
    mainMatrixC(whichRow,jMatrix+1)=myElement(numberOfElements).length;
    mainMatrixC(whichRow,((myElement(numberOfElements).jL)-1)*12+5)=-1;
    mainMatrixC(whichRow,((myElement(numberOfElements).jR)-1)*12+2)=1;

    whichRow=whichRow+1;
    
    mainMatrixC(whichRow,jMatrix+2)=myElement(numberOfElements).length;
    mainMatrixC(whichRow,((myElement(numberOfElements).jL)-1)*12+4)=1;
    mainMatrixC(whichRow,((myElement(numberOfElements).jR)-1)*12+1)=-1;

    
    whichRow=whichRow+1;
    
    mainMatrixC(whichRow,jMatrix+3)=myElement(numberOfElements).length;
    mainMatrixC(whichRow,((myElement(numberOfElements).jL)-1)*12+6)=-1;
    mainMatrixC(whichRow,((myElement(numberOfElements).jR)-1)*12+3)=+1;
    mainMatrixC(whichRow,((myElement(numberOfElements).jR)-1)*12+1)=-myElement(numberOfElements).length*myElement(numberOfElements).cosT;
    mainMatrixC(whichRow,jMatrix+2)=((myElement(numberOfElements).length)^2 / 2) *myElement(numberOfElements).cosT ;
    mainMatrixC(whichRow,jMatrix+1)=-((myElement(numberOfElements).length)^2 / 2) *myElement(numberOfElements).sinT ;
    %--------------------
    mainMatrixC(whichRow,((myElement(numberOfElements).jR)-1)*12+2)=-myElement(numberOfElements).length*myElement(numberOfElements).sinT;
    
    whichRow=whichRow+1;

end

function whichRow=zeroEqu(whichRow,myJoint,myElement,startJoint,endJoint)
    global mainMatrixC;
    global mainMatrixA;
    global howManyJoints;
    global howManyElement;
    
    %start
    mainMatrixC(whichRow,(myJoint(startJoint).number-1)*12+1)=1;
    whichRow=whichRow+1;
    mainMatrixC(whichRow,(myJoint(startJoint).number-1)*12+2)=1;
    whichRow=whichRow+1;
    mainMatrixC(whichRow,(myJoint(startJoint).number-1)*12+3)=1;
    whichRow=whichRow+1;
    %end
    mainMatrixC(whichRow,(myJoint(endJoint).number-1)*12+4)=1;
    whichRow=whichRow+1;
    mainMatrixC(whichRow,(myJoint(endJoint).number-1)*12+5)=1;
    whichRow=whichRow+1;
    mainMatrixC(whichRow,(myJoint(endJoint).number-1)*12+6)=1;
    whichRow=whichRow+1;
       
    for i=1:howManyJoints
        %In each Joint
        mainMatrixC(whichRow,(myJoint(i).number-1)*12+7)=1;  %Fx
        
        mainMatrixA(whichRow,1)=myJoint(i).fX;
        whichRow=whichRow+1;
        
        
        mainMatrixC(whichRow,(myJoint(i).number-1)*12+8)=1;  %Fy
        
        mainMatrixA(whichRow,1)=myJoint(i).fY;
        whichRow=whichRow+1;
        
        mainMatrixC(whichRow,(myJoint(i).number-1)*12+9)=1;  %M
        
        mainMatrixA(whichRow,1)=myJoint(i).m;
        whichRow=whichRow+1;
        
        if myJoint(i).isSX==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+10)=1;
            whichRow=whichRow+1;
        end
        if myJoint(i).isSY==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+11)=1;
            whichRow=whichRow+1;
        end
        if myJoint(i).isST==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+12)=1;
            whichRow=whichRow+1;
        end
        
        %--------------------------
        if myJoint(i).isCX==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+2)=1;
            whichRow=whichRow+1;
        end
        if myJoint(i).isCY==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+1)=1;
            whichRow=whichRow+1;
        end
        if myJoint(i).isCT==0
            mainMatrixC(whichRow,(myJoint(i).number-1)*12+3)=1;
            whichRow=whichRow+1;
        end
        
        %---------------------------
         
    end
    
    for i=1:howManyElement
        
        mainMatrixC(whichRow,(howManyJoints*12)+(i-1)*3+1)=1;
        mainMatrixA(whichRow,1)=myElement(i).qX;
        whichRow=whichRow+1;
        mainMatrixC(whichRow,(howManyJoints*12)+(i-1)*3+2)=1;
        mainMatrixA(whichRow,1)=myElement(i).qY;
        whichRow=whichRow+1;
        mainMatrixC(whichRow,(howManyJoints*12)+(i-1)*3+3)=1;
        mainMatrixA(whichRow,1)=myElement(i).qM;
        whichRow=whichRow+1;
    end
    
    
    
    
end
   
