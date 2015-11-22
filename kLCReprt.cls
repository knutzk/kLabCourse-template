%
%   kLCReprt is a LaTeX class for lab course reports and is part of the 
%   kLabCourse-template package.
%
%   kLabCourse-template has particularly been designed for the lab courses of
%   the Faculty of Physics (the "Faculty"), University of Goettingen, Germany.
%   Be aware that the template was neither created on authority of the Faculty
%   nor has it been approved by it.
%
%
%   Copyright 2015 Knut Zoch (knut DOT zoch AT gmail DOT com)
%
%   Licensed under the Apache License, Version 2.0 (the "License");
%   you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%
%       http://www.apache.org/licenses/LICENSE-2.0
%
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%
%
%   Version history:
%   ==================
%   2015/11/22: version 0.1
%
%
%   Detailed description:
%   =======================
%   To come ...
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kLCReprt}[2015/11/22 v0.1 Report class for lab course reports^^J \@spaces\@spaces\@spaces\space\space\space (based on the KOMA script classes by Markus Kohm)^^J \@spaces\@spaces\@spaces\space\space\space Copyright (C) 2015 Knut Zoch^^J]
% Maximum length for Class Info is 62 characters (for terminals with 80 chars)

% Provide warning, info, and error commands.
% Maximum length for warnings: 54
\newcommand*{\kLCReprt@warning}[1]{\ClassWarning{kLCReprt}{#1}}
\newcommand*{\kLCReprt@info}[1]{\ClassInfo{kLCReprt}{#1}}
\newcommand*{\kLCReprt@error}[2]{\ClassError{kLCReprt}{#1}{#2}}


% ==========================================================
%  D E C L A R I N G   C L A S S   O P T I O N S
% ==========================================================

% Essential packages for setting up the class options.
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage{kvoptions}
\RequirePackage{xstring}

% Bool and String options.
\DeclareBoolOption[true]{biblatex}
\DeclareBoolOption[false]{debug}
\DeclareBoolOption[false]{draft}
\DeclareComplementaryOption{final}{draft}
\DeclareBoolOption[true]{headinclude}
\DeclareBoolOption[true]{hyperref}
\DeclareBoolOption[false]{footinclude}
\DeclareBoolOption[false]{lightdraft}
\DeclareBoolOption[true]{microtype}
\DeclareBoolOption[false]{ngerman}
\DeclareBoolOption[true]{web}
\DeclareComplementaryOption{print}{web}

% Call the following options for the parent class.
\PassOptionsToClass{bibliography = totoc,%
                    fontsize     = 12pt,%
                    twoside      = yes,%
                    DIV          = 11,%
                    BCOR         = 6mm,%
                    }{scrartcl}

% Pass all unknown options to the parent class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessKeyvalOptions*


% ==========================================================
%  L O A D I N G   T H E   P A R E N T   C L A S S
% ==========================================================

% This class is based on the scrartcl class from the KOMA script family. The
% class will be loaded with the following options (by default, options in
% parentheses are scrtartcl's default values):
         % bibliography = totoc         % display bibliography in TOC
         % BCOR         = 6mm           % binding correction for margins
         % DIV          = 11            % page division factor 
         % fontsize     = 12pt          % set font size
         % footinclude  = (no)          % include footer in DIV calculation
         % headinclude  = yes           % include header in DIV calculation
         % headsepline  = (no)          % separate header and text with line
         % paper        = (a4)          % set paper size
         % titlepage    = (no)          % titlepage: yes/no/firstiscover
         % twoside      = yes           % twosided/singlesided document
\LoadClass{scrartcl}


% Hack for passing the headinclude option from this class.
\ifthenelse{\boolean{kLCReprt@headinclude}}{%
  \KOMAoptions{headinclude=true}
}{
  \KOMAoptions{headinclude=false}
}

% Hack for passing the footinclude option from this class.
\ifthenelse{\boolean{kLCReprt@footinclude}}{%
  \KOMAoptions{footinclude=true}
}{
  \KOMAoptions{footinclude=false}
}



% ==========================================================
%  E S S E N T I A L   D O C U M E N T   S E T T I N G S
% ==========================================================

% Adjust the general layout (include headers with section titles).
\RequirePackage{scrlayer-scrpage}       % package for advanced layout
\pagestyle{scrheadings}                 % load style for headings
\automark[subsection]{section}          % include section titles in header


% Optimise text spread with microtype package. 
\ifthenelse{\boolean{kLCReprt@microtype}}{%
  \RequirePackage[babel    = true,%     % use babel information
                  stretch  = 10,%       % reduce stretching (default: 20)
                  shrink   = 10,%       % reduce shrinking (default: 20)
                  final    = true,%     % ignore draft option of class
                  ]{microtype}
 }{%
   \kLCReprt@warning{Microtype package not loaded.}
}
  

\linespread{1.06}
\KOMAoptions{DIV=last}


% Height of 38 lines and width of 34 pica.
% \newlength{\LinesXXX}
% \setlength{\LinesXXX}{\topskip}
% \addtolength{\LinesXXX}{39\baselineskip}
% \areaset{34pc}{\LinesXXX}


% Declare essential text formatting commands (robust, no dependencies).
\newcommand*{\kLCReprt@textsw}[1]{\textit{#1}}
\newcommand*{\kLCReprt@swshape}{\itshape}
\ifdefstring{\kLCReprt@font}{minion}{%
  \renewcommand*{\kLCReprt@textsw}[1]{\textsw{#1}}
  \renewcommand*{\kLCReprt@swshape}{\swshape}
}{}

\newrobustcmd{\kLCReprt@allcaps}[1]{\kLCReprt@warning{%
    Spacing of small caps not adjusted! Using default\MessageBreak
    spacing now.}\textsc{\MakeUppercase{#1}}}
\newrobustcmd{\kLCReprt@lowcaps}[1]{\kLCReprt@warning{%
    Spacing of small caps not adjusted! Using default\MessageBreak
    spacing now.}\textsc{\MakeLowercase{#1}}}




% ==========================================================
%  ! ! !   F O R   D E B U G G I N G   S T O P   H E R E   ! ! !
% ==========================================================
\ifthenelse{\boolean{kLCReprt@debug}}{%
  \usepackage{amsmath,graphicx,float,biblatex}
  \let\marginnote\relax
  \let\cref\relax
  \let\href\relax
  \let\setstretch\relax
  \let\toprule\relax
  \let\midrule\relax
  \let\bottomrule\relax
  \let\textlcsc\textsc
  \let\textallc\textsc
  % \let\marginpar\relax
  \newcommand*{\subcaptionbox}[2][]{}
  \endinput
}{%
  \relax  % do nothing
}


% ==========================================================
%  S E T T I N G   U P   C A P T I O N S
% ==========================================================

\RequirePackage[format     = plain,%    % no indention btw label and caption
                margin     = 2.0em,%    % total margin (each left and right)
                ]{caption}

% Make use of sub-figures. Include them with the following syntax:
% \subcaptionbox{%caption\label{fig:%label}{\includegraphics{%figure}}
\RequirePackage[font+=footnotesize]{subcaption}



% ==========================================================
%  S E T T I N G   U P   T H E   B I B L I O G R A P H Y
% ==========================================================

% 1) Include package Biblatex for advanced bibliographies. The styles numeric/
% numeric-comp use a numerical reference system (comp compresses multiple
% citations: [1][2][3] ==> [1-3]).
% 2) Include customised bibliography style. The main difference is a shortened
% system for displaying journal articles (no title; DOI links are projected on
% the journal title).
% ==> Options:  linking=true/false, titles=true/false, overwrite=true/false
% ==> Defaults: linking=true, titles=false, overwrite=true
% ==> Use via \RequirePackage[overwrite=false, titles=true]{kbibstyle}
\ifthenelse{\boolean{kLCReprt@biblatex}}{%
    \PassOptionsToPackage{%
          backend      = biber,%        % use biber as backend
          style        = numeric,       % numerical references
          sorting      = none,%         % no sorting of entries
          maxcitenames = 1%             % use max. 2 author names
          }{biblatex}
    \RequirePackage{biblatex}                
    \RequirePackage{kLCBiblio}
  }{%
    \relax  % do nothing
}


% ==========================================================
%  S E T T I N G   U P   O T H E R   P A C K A G E S
% ==========================================================

\RequirePackage[utf8]{inputenc}         % encoding of document is UTF8
\RequirePackage{babel}                  % language support (hyphenation etc.)
\RequirePackage{amsmath}                % math package
\RequirePackage{booktabs}               % proper rules in tables
\RequirePackage[autostyle=true]{csquotes} % sync quoting style with language
\RequirePackage{enumitem}               % control layout of lists
\RequirePackage{float}                  % force floats to put "here" [!H]
\RequirePackage[T1]{fontenc}            % fontenc T1 (includes Umlaute)
\RequirePackage{graphicx}               % support for graphics inclusion
\RequirePackage{multirow}               % multi-row support for tables
\RequirePackage{rotating}               % flip floats
\RequirePackage{setspace}               % change line spacing easily
\RequirePackage{todonotes}              % add to-do notes to text
\RequirePackage{units}                  % correct units typesetting
\RequirePackage{wrapfig}                % wrap text around figures
\RequirePackage{xcolor}                 % support for custom colours
\RequirePackage{xspace}                 % custom commands do not eat spaces



% ==========================================================
%  P A C K A G E S   F O R   D R A F T I N G
% ==========================================================

\newcommand*{\issuelightdraftwarning}{\kLCReprt@warning{%
    Option "lightdraft" is set. To get full draft\MessageBreak
    features, set option "draft" (and deactivate\MessageBreak
    "lightdraft"). If this is meant to be a final\MessageBreak
    version, deactivate the lightdraft and draft\MessageBreak
    option or set the option "final".\MessageBreak}}


\ifthenelse{\boolean{kLCReprt@lightdraft}}{%
  \setboolean{kLCReprt@draft}{true}
}

\ifthenelse{\boolean{kLCReprt@draft}}{%
  \RequirePackage{draftwatermark}%      % include watermark on pages
  \SetWatermarkLightness{0.9}%          % ==> set high watermark lightness
  \SetWatermarkScale{5}%                % ==> scale watermark to 3
  \SetWatermarkText{Draft}%             % ==> set watermark to "DRAFT"
  \ifthenelse{\boolean{kLCReprt@ngerman}}{%
    \PassOptionsToPackage{german}{prelim2e}%
  }{}%
  \RequirePackage[scrtime]{prelim2e}%   % include footer with timestamp
  \ifthenelse{\boolean{kLCReprt@lightdraft}}{%
    \issuelightdraftwarning
    \KOMAoptions{draft=false}
  }{
    \RequirePackage{showframe}%         % show frames around text areas
    \KOMAoptions{draft=true}%           % use KOMA's drafting
  }
}{%
  \KOMAoptions{draft=false}
}



% ==========================================================
% M I S C E L L A N E O U S
% ==========================================================

\captionsetup{font={footnotesize,sf,stretch=1.1}}
\captionsetup{labelfont={footnotesize,sf,bf}}

\captionsetup[table]{belowskip=0.5em}

\numberwithin{equation}{section}        % include section in equation label
\numberwithin{table}{section}           % ------- " -------- table label
\numberwithin{figure}{section}          % ------- " -------- figure label

\graphicspath{{./figures/}}             % ==> look for figures in folder
\setlist{itemsep=-1ex}                  % ==> smaller spacing between items
\setlist[enumerate]{itemsep=0.1\baselineskip}
\setlist{leftmargin=1.5em}

% Alter some LaTeX defaults for better treatment of figures:
% See p.105 of "TeX Unbound" for suggested values.
% See pp. 199-200 of Lamport's "LaTeX" book for details.
% General parameters, for ALL pages:
\renewcommand{\topfraction}{0.9}	% max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}	% max fraction of floats at bottom
% Parameters for TEXT pages (not float pages):
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}             % 2 may work better
\setcounter{dbltopnumber}{2}            % for 2-column pages
\renewcommand{\dbltopfraction}{0.9}	% fit big float above 2-col. text
\renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
% Parameters for FLOAT pages (not text pages):
\renewcommand{\floatpagefraction}{0.7}	% require fuller float pages
% N.B.: floatpagefraction MUST be less than topfraction !!
\renewcommand{\dblfloatpagefraction}{0.7}	% require fuller float pages

 
 
% 1) Hyperref package for automatic cross-referencing and URL linking.
% ==> make it ALWAYS be the last package because it interferes with others!
% 2) Include package cleveref for auto-references with \cref.
\ifthenelse{\boolean{kLCReprt@hyperref}}{%
  \definecolor{Maroon}{cmyk}{0, 0.87, 0.68, 0.32}
  \definecolor{RoyalBlue}{cmyk}{1, 0.50, 0, 0}
  \definecolor{Black}{cmyk}{0, 0, 0, 0}
  \definecolor{webgreen}{rgb}{0,.5,0}
  \definecolor{webbrown}{rgb}{.6,0,0}

  \RequirePackage[%
          colorlinks = true,%           % coloured links instead of boxes
          urlcolor   = webbrown,        % use blue url links
          citecolor  = webgreen,        % use blue citing links
          linkcolor  = RoyalBlue,       % use blue crossref links
          linktocpage = true,           % link pages instead of titles in TOC
          ]{hyperref}

  \RequirePackage[nameinlink]{cleveref}
  
  % Apparently, some of the German abbreviations for equations and tables
% were missing. Adding them here (temporary hack).
  \addto\captionsngerman{
    \if@cref@abbrev
    \crefname{equation}{Gl.}{Gl.}
    \Crefname{equation}{Gleichung}{Gleichungen}
    \crefname{table}{Tab.}{Tab.}
    \Crefname{table}{Tabelle}{Tabellen}
    \fi
  }

  % If option "web" is given, do nothing. For option "print", hide links.
  \ifthenelse{\boolean{kLCReprt@web}}{%
    \relax % do nothing
  }{
    \hypersetup{hidelinks}
  }  
}{%
  \relax  % do nothing
}


% End of file
