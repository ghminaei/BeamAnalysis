classdef Elements

    
    properties
        
        number
        
        %Joints
        jL
        jR
        
        %Qs
        qX
        qY
        qM
        
        %length info
        sinT
        cosT
        length
 
        
    end
    
    methods
        function obj=calLength(obj,myJoint)
            obj.length = sqrt((myJoint(obj.jL).x - myJoint(obj.jR).x)^2 + (myJoint(obj.jL).y - myJoint(obj.jR).y)^2);
        end
        
        function obj=calSinT(obj,myJoint)
            obj.sinT = abs((myJoint(obj.jR).y - myJoint(obj.jL).y)./ obj.length);
        end
        
        function obj=calCosT(obj,myJoint)
            obj.cosT = abs((myJoint(obj.jR).x - myJoint(obj.jL).x)./ obj.length);
        end

    end
    
end

