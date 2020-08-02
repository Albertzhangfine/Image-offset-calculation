clear
clc
for t=1:19
    filename1=[num2str(t) '.jpg'];
    filename2=[num2str(t+1) '.jpg'];
    I11=imread(filename1);
    img1=rgb2gray(I11);
    I22=imread(filename2);
    img2=rgb2gray(I22);
    I2=img2;
    
    % 对参考图g1和匹配图g2进行基于区域的图像匹配
    % 相似性度量为归一化互相关函数，搜索策略为全搜索
    
    d=50;   %匹配精度
    m=1;
    
    for n=1:d:2000-d+1
        I1=img1(n:n+49,:);
        g1=I2;
        g2=I1;
        
        [pipei_height,pipei_width]=size(g2);
        [yuantu_height,yuantu_width]=size(g1);
        
        tic
        for i=1:yuantu_height-pipei_height
            
            j=1;
            temp_picture=imcrop(g1,[j,i,pipei_width-1,pipei_height-1]);
            X(i,j)=corr2(temp_picture,g2);
            
        end
        [x,i]=max(X);
        [y,j]=max(max(X));
        i=i(j);
        if X(i,j)>0.9
            delta(m)=abs(n-i);
            m=m+1;
        end
        
    end
    py=mode(delta)
    PixelOffset(t)=py;
end
