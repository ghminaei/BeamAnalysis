classdef Joints

    
    properties
        
        number
        
        %Internal Forces
        vL
        vR
        nL
        nR
        mL
        mR
        
        %External Forces
        fX
        fY
        m
        
        %Checking if Cs are 0 or 1 
        isCX
        isCY
        isCT
 
        
        %Checking if Ss are 0 or 1
        isSX
        isSY
        isST
        
        %Value of Ss
        sY %=V
        sX %=N
        sT %=M
        
        %length info
        x
        y
        
       % where % between=0 , start=1 , end=-1
        
    end
    
    methods

    end
    
end

