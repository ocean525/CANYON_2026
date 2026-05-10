clear;clc;
filename='Bathy_L30_W2_5';
L=30;% Length
W=2.5;% Width


sigmay = (W*1000/2)/2.5;  %Obtain required sigma based on canyon width
max_slope=1.7/L;  %Specify required slope to control canyon length
% max_slope = 0.2; --- obtain continental slope
%max_slope=0.1; -- obtain background slope for S10 S15..

load ycd.mat 
%% 
H_min=-300;
x_middle=1100/max_slope;
slope_center1=310e3;
slope_center2=slope_center1+x_middle;
H1=-900;
H2=-1400;
H=-2000;      
prec='real*8';
ieee='b';

% 
a=5;
b=0.00001;
b = logspace(log10(b/3), log10(b*20), 500); % 

clear y
%% First
for i=1:length(b)
g = @(x) a * tanh(b(i) * (x-slope_center1));%
y_func = @(x) tanh(g(x));%
y(:,i)=(H2-H)*0.5*(y_func(x)+1)+H;
%hold on
end

% -1400 controls the curve centered at 350km, -1700, ensuring sufficient curves exist.
% A curve is selected based on the required slope, taking only the first half,
% so that extending by slope yields a purely linear gradient, tangent to the next smooth region.
% -900 follows approximately the same logic.


for i=1:length(b)
y1=y(:,i);
dx = diff(x); % 
dy = diff(y1); % 
slopes(:,i) = dy ./ dx';
%hold on
if max(slopes(:,i))>max_slope-0.001
    index_tanh1=i;          % Select a specific curve
    disp(i)
    break
end
end

for i=1:length(x)
    if x(i)>=slope_center1; %  Find the index of the central point
       index_1=i
       break
    end
end

xx1=x(1:index_1);           % Only retain results before the central point
yy1=y(1:index_1,index_tanh1);  % Extract the curve segment before the central point to obtain the first section

%% Third section
for i=1:length(b)
g = @(x) a * tanh(b(i) * (x-slope_center2));%
y_func = @(x) tanh(g(x));
y(:,i)=(H_min-H1)*0.5*(y_func(x)+1)+H1;
%hold on
end

for i=1:length(b)
y1=y(:,i);
dx = diff(x); %
dy = diff(y1); % 
slopes(:,i) = dy ./ dx';
%hold on
if max(slopes(:,i))>max_slope-0.001
    index_tanh2=i;
    disp(i)
    break
end
end

for i=1:length(x)
    if x(i)>=slope_center1+x_middle; % % Take the second half, where the midpoint is the midpoint of first section plus the intermediate linear segment
       index_2=i
       break
    end
end

xx3=x(index_2:end);
yy3=y(index_2:end,index_tanh2);

%% Second section
clear yy2
for i=1:index_2-index_1-1
    xx2(i)=x(index_1+i);
    yy2(i)=yy1(end)+(x(index_1+i)-x(index_1))*max_slope;
end
yy2=yy2';

%% Concatenate
clear yfinal d
yfinal=[yy1;yy2;yy3];
y_gentle=yfinal;



clear yfinal
load 'y_slope.mat'% Add continental slope
%load 'y_slope_0_1.mat'%
%load 'y_slope_0_15.mat'%


for i=1:ny
d(:,i)=yfinal;
end

%%
dx = diff(x); % 
dy = diff(yfinal); % 
slopes_final = dy ./ dx';

dy = diff(y_gentle); % 
slopes_gentle = dy ./ dx';

[xx yy]=meshgrid(x,yc);

%% move slope
for i=1:length(x)
		if y_gentle(i)>-1990
		idx_1=i;  %Find the index of x at 1990 m
			for j=idx_1:length(x)
					if yfinal(j)>-1990
					idx_2=j; % Background slope, equal to the index embedded at 1990 m with the same slope
					break;  %%
					end
   		   end
        break;
		end
end

% The distance from subtracting the two indices gives the required rightward shift --- note that x resolution differs, so shift must be based on distance

x_move=x(idx_2)-x(idx_1)
x_new=x+x_move;
y_inner=interp1(x_new,y_gentle,x,'linear');

%Obtain the deviation from the background slope

y_diff=y_inner-yfinal';
y_diff(isnan(y_diff))=0;

F(ny,nx)=0;
F=ones(ny,1)*y_diff;%% Actual difference between the central canyon concavity and the original slope --- entire domain, uniform in y direction
F=F/min(y_diff);% Normalize it --- converted to coefficients, where 1 indicates the location of maximum deviation

%y_center =yc(end/2);  % 
y_center = 50000;
h = min(y_diff);         % -1.0586e+03    Value at the location of maximum deviation
G = h * exp(-((yy - y_center).^2) / (2 * sigmay^2));  %  Gaussian function

Z_modified = d'+ (F.*G);% Based on the background slope, adding F gives the deviation from the concavity, then multiplying by G
% extends outward on both sides via a Gaussian function, so the center matches the concavity
% while gradually becoming shallower toward both sides
                     
d=Z_modified';

fid=fopen(filename,'w',ieee); fwrite(fid,d,prec); fclose(fid);
disp('create Bathy succeed')
% 
figure
surf(xx/1000,yy/1000,d')
shading interp
colormap('turbo')
xlabel('X/km')
ylabel('Y/km')
zlabel('Z/m')
zlim([-3000 0])


