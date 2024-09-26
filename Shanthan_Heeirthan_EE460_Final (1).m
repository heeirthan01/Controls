%Heeirthan Shanthan Final Submission
INIT_S3D_01;
close all;
Shanthan_Heeirthan_GUI
Sconfig = 1;
set_param(gcs,'Location',[10 10 1270 970]);
set_param(gcs,'ZoomFactor','100');
SigNameProp(1);
bm = [1 1 -1 -1 0 0 0 0; 0 0 0 0 -1 1 1 -1; -1 1 -1 1 3 -3 3 -3];
pseudoinverse = pinv(bm).*2;
zeta = 1;
wn = 0.3159;
%Kd = 2*zeta*wn;
Kd = 2.1+0;
Kp = 1.1+0.2;
%Ki = 0.001;
Ki = 0.0001;
A = [0 1 0 0 0 0; 
    0 0 0 0 0 0;
    0 0 0 1 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 1;
    0 0 0 0 0 0];
B = [0 0 0;
    1/M 0 0;
    0 0 0;
    0 1/M 0;
    0 0 0;
    0 0 1/J];
C = [1 0 0 0 0 0;
     1 0 0 0 0 0;
     1 0 0 0 0 0;
     0 0 1 0 0 0;
     0 0 1 0 0 0;
     0 0 1 0 0 0;
     0 0 0 0 1 0;
     0 0 0 0 1 0;
     0 0 0 0 1 0];
D = [0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0;
      0 0 0];
ep = [-1;-1.1;-1.2;-1.3;-1.4;-1.5];
L = place(A',C',ep)';

[TFlp] = c2d(tf(10*wn,[1,10*wn]),0.01);
[TFhp] = c2d(tf([1 0],[1 10*wn]),0.01);

wcf = 2;
wcft = 10;
[TFclpxy] = c2d(tf(wcf,[1,wcf]),0.01);
[TFchpxy] = c2d(tf([1],[1 wcf]),0.01);
[TFclptheta] = c2d(tf(wcft,[1,wcft]),0.01);
[TFchptheta] = c2d(tf([1],[1 wcft]),0.01);
Numlp = TFlp.Num{1};
Denlp = TFlp.Den{1};
Numhp = TFhp.Num{1};
Denhp = TFhp.Den{1};

Numclpxy = TFclpxy.Num{1};
Denclpxy = TFclpxy.Den{1};
Numchpxy = TFchpxy.Num{1};
Denchpxy = TFchpxy.Den{1};

Numclptheta = TFclptheta.Num{1};
Denclptheta = TFclptheta.Den{1};
Numchptheta = TFchptheta.Num{1};
Denchptheta = TFchptheta.Den{1};

Pnewdata = [LVL.P1 LVL.P2 LVL.P3 LVL.P4];

%Point 1:
if(norm(Pnewdata(1:end-1,1) - 0) >=40)
    TFP1 = 6;
elseif(norm(Pnewdata(1:end-1,1) - 0) < 40 && norm(Pnewdata(1:end-1,1) - 0) >=20)
    TFP1 = 5;
elseif(norm(Pnewdata(1:end-1,1) - 0) < 20 && norm(Pnewdata(1:end-1,1) - 0) >=10)
    TFP1 = 3;
else
    TFP1 = 2;
end

if(norm(Pnewdata(3,2) - Pnewdata(3,1)) >=40)
    TFP1z = 4;
elseif(norm(Pnewdata(3,2) - Pnewdata(3,1)) < 40 && norm(Pnewdata(3,2) - Pnewdata(3,1)) >=20)
    TFP1z = 3;
elseif(norm(Pnewdata(3,2) - Pnewdata(3,1)) < 20 && norm(Pnewdata(3,2) - Pnewdata(3,1)) >=10)
    TFP1z = 2;
else
    TFP1z = 1;
end


%Point 2:

if(norm(Pnewdata(1:end-1,2) - Pnewdata(1:end-1,1)) >=40)
    TFP2 = 6;
elseif(norm(Pnewdata(1:end-1,2) - Pnewdata(1:end-1,1)) < 40 && norm(Pnewdata(1:end-1,2) - Pnewdata(1:end-1,1)) >=20)
    TFP2 = 5;
elseif(norm(Pnewdata(1:end-1,2) - Pnewdata(1:end-1,1)) < 20 && norm(Pnewdata(1:end-1,2) - Pnewdata(1:end-1,1)) >=10)
    TFP2 = 3;
else
    TFP2 = 2;
end

if(norm(Pnewdata(3,2) - Pnewdata(3,1)) >=40)
    TFP2z = 4;
elseif(norm(Pnewdata(3,2) - Pnewdata(3,1)) < 40 && norm(Pnewdata(3,2) - Pnewdata(3,1)) >=20)
    TFP2z = 3;
elseif(norm(Pnewdata(3,2) - Pnewdata(3,1)) < 20 && norm(Pnewdata(3,2) - Pnewdata(3,1)) >=10)
    TFP2z = 2;
else
    TFP2z = 1;
end


%Point 3:
if(norm(Pnewdata(1:end-1,3) - Pnewdata(1:end-1,2)) >=40)
    TFP3 = 6;
elseif(norm(Pnewdata(1:end-1,3) - Pnewdata(1:end-1,2)) < 40 && norm(Pnewdata(1:end-1,3) - Pnewdata(1:end-1,2)) >=20)
    TFP3 = 5;
elseif(norm(Pnewdata(1:end-1,3) - Pnewdata(1:end-1,2)) < 20 && norm(Pnewdata(1:end-1,3) - Pnewdata(1:end-1,2)) >=10)
    TFP3 = 3;
else
    TFP3 = 2;
end

if(norm(Pnewdata(3,3) - Pnewdata(3,2)) >=40)
    TFP3z = 4;
elseif(norm(Pnewdata(3,3) - Pnewdata(3,2)) < 40 && norm(Pnewdata(3,3) - Pnewdata(3,2)) >=20)
    TFP3z = 3;
elseif(norm(Pnewdata(3,3) - Pnewdata(3,2)) < 20 && norm(Pnewdata(3,3) - Pnewdata(3,2)) >=10)
    TFP3z = 2;
else
    TFP3z = 1;
end


%Point 4

if(norm(Pnewdata(1:end-1,4) - Pnewdata(1:end-1,3)) >=40)
    TFP4 = 6;
elseif(norm(Pnewdata(1:end-1,4) - Pnewdata(1:end-1,3)) < 40 && norm(Pnewdata(1:end-1,4) - Pnewdata(1:end-1,3)) >=20)
    TFP4 = 5;
elseif(norm(Pnewdata(1:end-1,4) - Pnewdata(1:end-1,3)) < 20 && norm(Pnewdata(1:end-1,4) - Pnewdata(1:end-1,3)) >=10)
    TFP4 = 3;
else
    TFP4 = 2;
end

if(norm(Pnewdata(3,4) - Pnewdata(3,3)) >=135)
    TFP4z = 4;
elseif(norm(Pnewdata(3,4) - Pnewdata(3,3)) < 135 && norm(Pnewdata(3,4) - Pnewdata(3,3)) >=90)
    TFP4z = 3;
elseif(norm(Pnewdata(3,4) - Pnewdata(3,3)) < 90 && norm(Pnewdata(3,4) - Pnewdata(3,3)) >=45)
    TFP4z = 2;
else
    TFP4z = 1;
end
