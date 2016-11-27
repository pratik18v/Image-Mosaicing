function H = computeH(t1, t2)

ax = double.empty(0);
ay = double.empty(0);
A = double.empty(0);


for i=1:size(t1,2)

    ax = [-t1(1,i);-t1(2,i);-1;0;0;0;t2(1,i)*t1(1,i);t2(1,i)*t1(2,i);t2(1,i)];
    ay = [0;0;0;-t1(1,i);-t1(2,i);-1;t2(2,i)*t1(1,i);t2(2,i)*t1(2,i);t2(2,i)];
    A = [A;ax';ay'];

end

[~,~,V] = svd(A,0);
H = reshape(V(:,9), [3,3]);
H = H';

end

