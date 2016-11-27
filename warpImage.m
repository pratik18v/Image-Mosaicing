function [Iwarp, Imerge] = warpImage(Iin, Iref, H)

[m1,n1,~] = size(Iin);
[m2,n2,~] = size(Iref);
Iwarp = uint8.empty(0);
Imerge = uint8.empty(0);
I_ref_trns = uint8.empty(0);
v = double.empty(0);

%Transforming corner points from original image using H
corners = H*[ 1  1 n1 n1 ; ...
              1 m1  1 m1 ; ...
              1  1  1  1 ];
%Converting transformed co-ordinates into cartesian from homogeneous form
x_cr = corners(1,:)./corners(3,:);
y_cr = corners(2,:)./corners(3,:);
%Finding values of x and y by which we need to translate the warped image
%to get all the corners inside the frame
xtrns_min = min(x_cr(:));
ytrns_min = min(y_cr(:));

%Calculating new transformation matrix combining homography and translation
trns_mat = [1,0,-xtrns_min;0,1,-ytrns_min;0,0,1];
full_trns = trns_mat*H;

%Calculating the corner points resulting from this combined transformation
corners = full_trns*[ 1  1 n1 n1 ; 
                      1 m1  1 m1 ; 
                      1  1  1  1 ];
%Calculating cartesian from homogeneous co-ordinates
x_cr = corners(1,:)./corners(3,:);
y_cr = corners(2,:)./corners(3,:);
%Finding out the max x and y  values in which the transformed image
%stretches
xtrns_max = floor(max(x_cr(:)));
ytrns_max = floor(max(y_cr(:)));

%Matching points from warped image to original image
for ii = 1:ytrns_max*xtrns_max
    
        %Get homogeneous co-ordinates for the image
        [x,y] = ind2sub([ytrns_max, xtrns_max], ii);                        
        v = [y x 1];

        %Apply transformation
        v_trans = full_trns\v';

        %Get cartesian co-ordinates
        v_x = (floor(v_trans(2)/v_trans(3)));
        v_y = (floor(v_trans(1)/v_trans(3)));
        
        %Map new image to old image
        if((v_x>=1)&&(v_y>=1)&&(v_x<=m1)&&(v_y<=n1))
            Iwarp(x,y,:) = Iin(v_x,v_y,:);
            %Assign values to Imerge too as we loop through Iwarp
            Imerge(x,y,:) = Iwarp(x,y,:);
        end
        
        %Transforming Iref according to the translation we introduced in Iin
        v_trans_ref = trns_mat\v';
        %Homegenous to cartesian
        v_x_ref = (floor(v_trans_ref(2)/v_trans_ref(3)));
        v_y_ref = (floor(v_trans_ref(1)/v_trans_ref(3)));
        
        %Mapping points from warped image to original image
        if((v_x_ref>=1)&&(v_y_ref>=1)&&(v_x_ref<=m2)&&(v_y_ref<=n2))
            I_ref_trns(x,y,:) = Iref(v_x_ref,v_y_ref,:);
            %Assign values to Imerge too as we loop through Iref, values
            %already assigned will be overwritten
            Imerge(x,y,:) = I_ref_trns(x,y,:);
        end        
        
end

end
