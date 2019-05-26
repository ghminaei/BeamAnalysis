function internalForces(myElement,myJoint)
        fileName='outPut.txt';
        fid=fopen(fileName,'at');
        fprintf(fid,'\nInternal Forces: \n');
        global howManyElement;
        xStart=sqrt((myJoint(myElement(1).jL).x)^2+ (myJoint(myElement(1).jL).y)^2);
        
        for i=1:howManyElement
            if i>1
                xStart=xStart+myElement(i-1).length;
            end
            fprintf(fid,'Element %d  :\n',i);
            
            dx=linspace(xStart,xStart+myElement(i).length);
            
            n=(myJoint(myElement(i).jL).nR -(myElement(i).qX) * (dx-xStart))*(myElement(i).cosT) ...
                + (-myJoint(myElement(i).jL).vR -(myElement(i).qY) * (dx-xStart))*(myElement(i).sinT);
            
            formatSpace='N%d = %.3f + %.3f * x\n';
            
            const1=myJoint(myElement(i).jL).nR *(myElement(i).cosT) - myJoint(myElement(i).jL).vR *(myElement(i).sinT);
            const2=-(myElement(i).qX) *(myElement(i).cosT) -(myElement(i).qY) *(myElement(i).sinT);
           
            
            fprintf(fid,formatSpace,i,const1,const2);
            figure(1)
            plot(dx,n)
            title('Internal Force: x-N')
            xlabel('x')
            ylabel('N')
            
            hold on
            
            v=(myJoint(myElement(i).jL).nR -(myElement(i).qX)* (dx-xStart))*(myElement(i).sinT)...
                +(myJoint(myElement(i).jL).vR +(myElement(i).qY)* (dx-xStart))*(myElement(i).cosT);
            
            formatSpace='V%d = %.3f + %.3f * x\n';
            
            const1=myJoint(myElement(i).jL).nR *(myElement(i).sinT)+ myJoint(myElement(i).jL).vR *(myElement(i).cosT);
            const2=-(myElement(i).qX) *(myElement(i).sinT) +(myElement(i).qY) * (myElement(i).cosT);
            
            fprintf(fid,formatSpace,i,const1,const2);
            figure(2)
            plot(dx,v)
            title('Internal Force: x-V')
            xlabel('x')
            ylabel('V')
            
            hold on
            
            
            m=myJoint(myElement(i).jL).mR +(myJoint(myElement(i).jL).vR * (dx-xStart) * myElement(i).cosT)...
                + (myJoint(myElement(i).jL).nR * dx * myElement(i).sinT)...
                +(myElement(i).qX)* (dx-xStart) .* (dx-xStart) *(myElement(i).sinT)*0.5 +(myElement(i).qY)* (dx-xStart) .* (dx-xStart) *(myElement(i).cosT)*0.5 ;
            
            formatSpace='M%d = %.3f + %.3f * x + %.3f * x^2\n';
            
            const1=myJoint(myElement(i).jL).mR ;
            const2= (myJoint(myElement(i).jL).vR * myElement(i).cosT) + (myJoint(myElement(i).jL).nR * myElement(i).sinT);
            const3=(myElement(i).qX) *(myElement(i).sinT)*0.5 +(myElement(i).qY) *(myElement(i).cosT)*0.5;
            fprintf(fid,formatSpace,i,const1,const2,const3);
            figure(3)
            plot(dx,m)
            title('Internal Force: x-M')
            xlabel('x')
            ylabel('M')
            
            hold on
        end
        
        
        fclose(fid);
end