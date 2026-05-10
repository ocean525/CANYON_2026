delete T.init tRef Bathy delXvar
clear 
clc
prec='real*8';
ieee='b';
%% Adjust resolution progressively from left to right to determine grid count
clear dx1 dx_v1 dx_v2 dx2
dx1=1000;% 1km，
dx2=200;% 200m，
for i=1:10000
dx_v1(i)=1000-20*i;% 1km-200m
     if dx_v1(i)<=dx2
        index_v1=i;
        break
     end
end
dx_v1(index_v1)=[];
dx_v2=flip(dx_v1);
%% Define boundary points of five regions to obtain x-coordinates of the entire domain
area_1_end=280e3
area_2_end=area_1_end+sum(dx_v1)%23.4km 49.3km
area_3_end=370e3%
area_4_end=area_3_end+sum(dx_v1)%23.4km +49.3km
area_5_end=600e3%

len_1=(area_1_end/dx1);
clear x
x(1)=dx1;
for i=2:len_1
x(i)=x(i-1)+dx1;
end
len_2=length(dx_v1)+len_1;
for i=len_1+1:len_2
x(i)=x(i-1)+dx_v1(i-len_1);
end
for i=len_2+1:10000
    if x(i-1)<area_3_end
    x(i)=x(i-1)+dx2;
    else 
        len_3=i;
        disp(i);
    break
    end
end
len_4=length(dx_v2)+len_3-1;
for i=len_3:len_4
x(i)=x(i-1)+dx_v2(i-len_3+1);
end
for i=len_4+1:10000
    if x(i-1)<=area_5_end
    x(i)=x(i-1)+dx1;
    else 
        len_5=i;
        disp(i);
    break
    end
end


add_x=mod(len_5,10);%Adjust grid count to a multiple of 10
if add_x==0
disp('000000000000000add_x')
end

for i=1:11-add_x
x(len_5+i-1)=x(len_5+i-2)+dx1; 
end
%%  Determine grid count
nx=length(x);
dx=zeros(nx,1);
dx(1)=x(1);
for i=2:nx
dx(i) = x(i)-x(i-1);
end

%% y grids
clear dy1 dy_v1 dy_v2 dy2 y
dy1=1000;%
dy2=50;%
for i=1:10000
dy_v1(i)=1000-20*i;
     if dy_v1(i)<=dy2
        indey_v1=i;
        break
     end
end
dy_v1(indey_v1)=[];
dy_v2=flip(dy_v1);


y_1_end=18e3
y_2_end=y_1_end+sum(dy_v1)%
y_3_end=y_2_end+15.5e3
y_4_end=y_3_end+sum(dy_v1)%
y_5_end=y_4_end+y_1_end



len_y1=round(y_1_end/dy1);
clear y
y(1)=dy1;
for i=2:len_y1
y(i)=y(i-1)+dy1;
end
len_y2=length(dy_v1)+len_y1;
for i=len_y1+1:len_y2
y(i)=y(i-1)+dy_v1(i-len_y1);
end
for i=len_y2+1:10000
    if y(i-1)<y_3_end
    y(i)=y(i-1)+dy2;
    else 
        len_y3=i;
        disp(i);
    break
    end
end
len_y4=length(dy_v2)+len_y3-1;
for i=len_y3:len_y4
y(i)=y(i-1)+dy_v2(i-len_y3+1);
end
for i=len_y4+1:10000
    if y(i-1)<y_5_end
    y(i)=y(i-1)+dy1;
    else 
        len_y5=i;
        disp(i);
    break
    end
end

y(end)=100e3;



ny=length(y);
dy=zeros(ny,1);
dy(1)=y(1);
for i=2:ny
dy(i) = y(i)-y(i-1);
end


fid=fopen('delYvar','w',ieee); fwrite(fid,dy,prec); fclose(fid);
disp('create delYvar succeed')

% z grids
nz=200;
H=2000;
dz=H/nz;
z=-dz/2:-dz:-H;
sprintf('delZ = %d * %7.6g,',nz,dz)

fid=fopen('delXvar','w',ieee); fwrite(fid,dx,prec); fclose(fid);
disp('create delXvar succeed')
%% Stratification
gravity=9.81;
talpha=2.0e-4;
waveL=60e3;
wavek=2*pi/waveL;
w=2*pi/43200;
H=2000;
N2=w^2/(wavek*H/pi)^2+w^2


%Tz=(12-4)/2000;
%N2=gravity*talpha*Tz;%7.8480e-06

Tz=N2/gravity/talpha;


%Temperature profile
Tref=Tz*z+12;
[sprintf('Tref =') sprintf(' %8.6g,',Tref)]

t=0.0*rand([nx,ny,nz]);
for k=1:nz
t(:,:,k) = t(:,:,k) + Tref(k);
end
%%  Generate initial temperature field and reference temperature for each layer, terrain is not involved, only nx from topography is needed
fid=fopen('T.init','w',ieee); fwrite(fid,t,prec); fclose(fid);
disp('create T.init succeed')
fid=fopen('tRef','w',ieee); fwrite(fid,Tref,prec); fclose(fid);
disp('create tRef succeed')

%% 
yc=y;
d=0.0*rand([nx,ny]);
save('ycd.mat','yc','d','nx','ny','nz','x')