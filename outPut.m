function myJoint=outPut(myElement,myJoint)
    global mainMatrixB;
    global howManyJoints;
    global howManyElement;
    
       for i=1:howManyJoints
        iMatrix=(i-1)*12;
        myJoint(i).vL=mainMatrixB(iMatrix+1,1);
        myJoint(i).vR=mainMatrixB(iMatrix+4,1);
        myJoint(i).nL=mainMatrixB(iMatrix+2,1);
        myJoint(i).nR=mainMatrixB(iMatrix+5,1);
        myJoint(i).mL=mainMatrixB(iMatrix+3,1);
        myJoint(i).mR=mainMatrixB(iMatrix+6,1);
        
        myJoint(i).sY=mainMatrixB(iMatrix+11,1);
        myJoint(i).sX=mainMatrixB(iMatrix+10,1);
        myJoint(i).sT=mainMatrixB(iMatrix+12,1);

    end
    
    dispOutPut(myJoint)
    
end

function dispOutPut(myJoint)
    global howManyJoints;
    fileName='outPut.txt';
    fid=fopen(fileName,'wt');
    fprintf(fid,'Answers: \n');
    for i=1 : howManyJoints
        if myJoint(i).isCX==0 || myJoint(i).isCY==0 || myJoint(i).isCT==0
            %It is a connection
            if myJoint(i).isCX==1
                formatSpaceXLeft='Cx(left)%d =  %.3f \n';
                formatSpaceXRight='Cx(right)%d =  %.3f \n';
                fprintf(fid,formatSpaceXLeft,i,myJoint(i).nL);
                fprintf(fid,formatSpaceXRight,i,myJoint(i).nR);
            end
            
            if myJoint(i).isCY==1
                formatSpaceYLeft='Cy(left)%d =  %.3f \n';
                formatSpaceYRight='Cy(right)%d =  %.3f \n';
                fprintf(fid,formatSpaceYLeft,i,myJoint(i).vL);
                fprintf(fid,formatSpaceYRight,i,myJoint(i).vR);
                
            end
            
            if myJoint(i).isCT==1
                formatSpaceMLeft='Cm(left)%d =  %.3f \n';
                formatSpaceMRight='Cm(right)%d =  %.3f \n';
                fprintf(fid,formatSpaceMLeft,i,myJoint(i).mL);
                fprintf(fid,formatSpaceMRight,i,myJoint(i).mR); 
            end
     
        end
        
        
        
        if myJoint(i).isSX==1 || myJoint(i).isSY==1 || myJoint(i).isST==1
            %It is a connection
            if myJoint(i).isSX==1
                formatSpaceX='Sx%d =  %.3f \n';
                fprintf(fid,formatSpaceX,i,myJoint(i).sX);
            end
            
            if myJoint(i).isSY==1
                formatSpaceX='Sy%d =  %.3f \n';
                fprintf(fid,formatSpaceX,i,myJoint(i).sY);
                
            end
            
            if myJoint(i).isST==1
                formatSpaceX='St%d =  %.3f \n';
                fprintf(fid,formatSpaceX,i,myJoint(i).sT); 
            end
     
        end
        
    end
    
    
    
    
    fclose(fid)
end