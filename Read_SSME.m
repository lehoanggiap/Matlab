function [x, x_choked, z, A_star] = Read_SSME()
file = fopen('SSME.txt');
data = textscan(file, '%f%f%f', 'Delimiter',',');
fclose(file);
x = data{1,1};
x = x.';
x = x./100;
z = data{1,2};
z = z.';
z = z./100;
[z_min, I] = min(z);
x_choked = x(I);
A_star = pi*z_min^2;
end