function AO_inversor(R1,R2,VAL,Val,A,N,F,semnal)

% ========== mesaje erori ===================%
if R1==0||R2==0
    f = errordlg('Rezistenta zero?','Error');
end
if R1<0||R2<0
    f = errordlg('Rezistenta negativa? Impresionant.','Error');
end
if F<0
    f = errordlg('Frecventa negativa?','Error');
elseif F>2600
    f = errordlg('Frecventa este prea mare!','Error');
end

% ========== figura interfata ===================%
Fig=figure('Name','Amplificatoare AO',...
'Units','normalized',...
'NumberTitle','off',...
'Position',[0.16 0.1 0.7 0.7],...
'Color','#F0F0F0');

% ========== buton ne/inversor ===================%
Bp_u=uicontrol('Style','PopupMenu',...
'Units','normalized',...
'Position',[0.05 0.9 0.16 0.05],...
'FontSize',10,... 
'String','Amplificator AO Inversor|Amplificator AO Neinversor',...
'Callback','close;AO_neinversor(R1,R2,VAL,Val,A,N,F,semnal)');

% ========== imagine ===================%
img = imread('inversor.png');
image(img);
x = 0.05;
y = 0.6;
width = 0.3; % measured relative to the figure width
height = 0.3; % measured relative to the figure height
set(gca,'units','normalized','position',[x y width height])

% ========== grup1 butoane ===================%
RadioGroup=uibuttongroup('Visible','on',...
'ForegroundColor','black',...
'Title','Parametrii circuitului',...
'FontSize',15,...
'TitlePosition','centertop',...
'Tag','radiobutton',...
'Position',[0.4 0.6 0.15 0.3]);

% ========== R1 ===================%
uicontrol('Style','text',... % text pt R1
'Units','normalized',...
'Position',[0.03 0.85 0.3 0.1],...
'foregroundcolor','black',...
'String','R1 [Ohm]',...
'Parent',RadioGroup);
uicontrol('Style','edit',... % edit pt R1
 'Units','normalized',...
 'Position',[0.45 0.87 0.3 0.1],...
 'String',R1,...
 'Parent',RadioGroup,...
 'Callback',['R1=','str2num(get(gco,''String''))']);

% ========== R2 ===================%
uicontrol('Style','text',... % text pt R2
'Units','normalized',...
'Position',[0.03 0.65 0.3 0.1],...
'foregroundcolor','black',...
'String','R2 [Ohm]',...
'Parent',RadioGroup);
uicontrol('Style','edit',... % edit pt R2
 'Units','normalized',...
 'Position',[0.45 0.67 0.3 0.1],...
 'String',R2,...
 'Parent',RadioGroup,...
 'Callback',['R2=','str2num(get(gco,''String''))']);

% ========== +Val ===================%
uicontrol('Style','text',... % text pt Val+
'Units','normalized',...
'Position',[0.03 0.38 0.3 0.1],...
'foregroundcolor','black',...
'String','+Val [V]',...
'Parent',RadioGroup);
uicontrol('Style','edit',... % edit pt Val+
 'Units','normalized',...
 'Position',[0.45 0.4 0.3 0.1],...
 'String',VAL,...
 'Parent',RadioGroup,...
 'Callback',['VAL=','str2num(get(gco,''String''))']);

% ========== -Val ===================%
uicontrol('Style','text',... % text pt Val-
'Units','normalized',...
'Position',[0.03 0.18 0.3 0.1],...
'foregroundcolor','black',...
'String','-Val [V]',...
'Parent',RadioGroup);
uicontrol('Style','edit',... % edit pt Val-
 'Units','normalized',...
 'Position',[0.45 0.2 0.3 0.1],...
 'String',Val,...
 'Parent',RadioGroup,...
 'Callback',['Val=','str2num(get(gco,''String''))']);

% ========== grup2 butoane ===================%
RadioGroup2=uibuttongroup('Visible','on',...
'ForegroundColor','black',...
'Title','Semnale de intrare',...
'FontSize',15,...
'TitlePosition','centertop',...
'Tag','radiobutton',...
'Position',[0.58 0.6 0.15 0.3]);

% ========== A ===================%
uicontrol('Style','text',... % text pt A
'Units','normalized',...
'Position',[0.03 0.75 0.3 0.1],...
'foregroundcolor','black',...
'String','A [V]',...
'Parent',RadioGroup2);
uicontrol('Style','edit',... % edit pt A
 'Units','normalized',...
 'Position',[0.45 0.77 0.3 0.1],...
 'String',A,...
 'Parent',RadioGroup2,...
 'Callback',['A=','str2num(get(gco,''String''))']);

% ========== N ===================%
uicontrol('Style','text',... % text pt N
'Units','normalized',...
'Position',[0.03 0.55 0.3 0.1],...
'foregroundcolor','black',...
'String','N',...
'Parent',RadioGroup2);
uicontrol('Style','edit',... % edit pt N
 'Units','normalized',...
 'Position',[0.45 0.57 0.3 0.1],...
 'String',N,...
 'Parent',RadioGroup2,...
 'Callback',['N=','str2num(get(gco,''String''))']);

% ========== F ===================%
uicontrol('Style','text',... % text pt F
'Units','normalized',...
'Position',[0.03 0.35 0.3 0.1],...
'foregroundcolor','black',...
'String','f [Hz]',...
'Parent',RadioGroup2);
uicontrol('Style','edit',... % edit pt F
 'Units','normalized',...
 'Position',[0.45 0.37 0.3 0.1],...
 'String',F,...
 'Parent',RadioGroup2,...
 'Callback',['F=','str2num(get(gco,''String''))']);

% ========== buton calcul ===================%
uicontrol('Style','pushbutton',...
 'Units','normalized',...
 'Position',[0.8 0.8 0.1 .05],...
 'string','CALCULEAZA',...
 'Callback','close,AO_inversor(R1,R2,VAL,Val,A,N,F,semnal)');

% ========== sinusoidal/triunghiular ===================%
uicontrol('Style','PopupMenu',...
'Units','normalized',...
'Position',[0.598 0.6 0.1 .05],...
'String','Sinusoidal|Triunghiular',...
'Value',semnal,...
'Callback','semnal=get(gco,''Value'');close;AO_inversor(R1,R2,VAL,Val,A,N,F,semnal)'); 

% ========== Amplificarea ===================%
Amplif=-R2./R1;
uicontrol('Style','text',...
          'Units','normalized',...
          'Position', [0.8 0.7 0.1 .03],...
          'FontSize',15,...
          'foregroundcolor','black',...
          'String','Amplificarea');
uicontrol('Style','text',...
          'Units','normalized',...
          'Position', [0.8 0.65 0.1 .03],...
          'FontSize',15,...
          'String',Amplif);

% ========== tensiune intrare ===================%
T=1/F; % perioada
t=0:T/100:N*T; % timp in funct de nr de perioade N
nt=length(t);  % lungimea t

% ========== gf tensiune intrare ===================%
switch(semnal)
    case 1
    Vi=A.*sin(2.*pi.*F.*t);
    subplot('position',[0.05 0.2 0.25 0.25]);
    plot(t,Vi,'LineWidth', 2, 'Color','#000000');
    grid on;
    title('Tensiunea de intrare [Vi]');
    xlabel('Timp [ms]');
    ylabel('Amplitudine [V]');
    case 2
    Vi=(2*A/pi)*asin(sin(2.*pi.*F.*t));
    subplot('position',[0.05 0.2 0.25 0.25]);
    plot(t,Vi,'LineWidth', 2, 'Color','#000000');
    grid on;
    title('Tensiunea de intrare [Vi]');
    xlabel('Timp [ms]');
    ylabel('Amplitudine [V]');
end

% ========== gf tensiune iesire ===================%
for k=1:nt 
    Vo(k)=Amplif.*Vi(k);
    if Vo(k)<Val
       Vo(k)=Val;
    elseif Vo(k)>VAL
       Vo(k)=VAL;
    end
end
subplot('position',[0.38 0.2 0.25 0.25]);
plot(t,Vo,'LineWidth', 2, 'Color','#000000');
grid on;
title('Tensiunea de iesire [Vo]');
xlabel('Timp [ms]');
ylabel('Amplitudine [V]');
line('XData', [0 N*T], 'YData', [Val Val], 'LineWidth', 2, 'Color','r'); % Amplif MAX
line('XData', [0 N*T], 'YData', [VAL VAL], 'LineWidth', 2, 'Color','r'); % Amplif MIN

% ========== gf cstv ===================%
PH=max(Vi); % Vi MAX
PL=min(Vi); % Vi MIN
subplot('position',[0.71 0.2 0.25 0.25]);
plot(Vi,Vo,'LineWidth', 2, 'Color','#000000');
axis([PL-2 PH+2 Val-2 VAL+2])
grid on;
title('CSTV');
xlabel('[Vi]');
ylabel('[Vo]');
