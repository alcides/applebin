FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��

	Open Terminal Here
	
	A toolbar script for Mac OS X 10
	
	Written by Marc Liyanage
	
	
	See http://www.apple.com/applescript/macosx/toolbar_scripts/ for
	more information about toolbar scripts.
	
	See http://www.entropy.ch/software/applescript/ for the latest
	version of this script.
	
	
	History:
	
	30-OCT-2001: Version 1.0, adapted from one of the example toolbar scripts
	30-OCT-2001: Now handles embedded single quote characters in file names
	30-OCT-2001: Now handles folders on volumes other than the startup volume
	30-OCT-2001: Now handles click on icon in top-level (machine) window
	31-OCT-2001: Now displays a nicer terminal window title, courtesy of Alain Content
	11-NOV-2001: Now folders within application packages (.app directories) and has a new icon
	12-NOV-2001: New properties to set terminal columns and rows as the Terminal does not use default settings
	14-NOV-2001: Major change, now handles 8-bit characters in all shells, and quotes and spaces in tcsh
	18-NOV-2001: Version 1.1: Rewrite, now uses a temporary file  ~/.OpenTerminalHere to communicate
	             the directory name between AppleScript and the shell because this is much more reliable for 8-bit characters
	16-JAN-2006: Version 2.0: Rewrite, now uses "quoted form of" and "POSIX Path". This gets rid of
	             Perl and temp files, but it no longer handles files instead of folders.
	24-JAN-2007: Version 2.1: Integrated enhancements by Stephan Hradek, can again handle dropped files.

     � 	 	� 
 
 	 O p e n   T e r m i n a l   H e r e 
 	 
 	 A   t o o l b a r   s c r i p t   f o r   M a c   O S   X   1 0 
 	 
 	 W r i t t e n   b y   M a r c   L i y a n a g e 
 	 
 	 
 	 S e e   h t t p : / / w w w . a p p l e . c o m / a p p l e s c r i p t / m a c o s x / t o o l b a r _ s c r i p t s /   f o r 
 	 m o r e   i n f o r m a t i o n   a b o u t   t o o l b a r   s c r i p t s . 
 	 
 	 S e e   h t t p : / / w w w . e n t r o p y . c h / s o f t w a r e / a p p l e s c r i p t /   f o r   t h e   l a t e s t 
 	 v e r s i o n   o f   t h i s   s c r i p t . 
 	 
 	 
 	 H i s t o r y : 
 	 
 	 3 0 - O C T - 2 0 0 1 :   V e r s i o n   1 . 0 ,   a d a p t e d   f r o m   o n e   o f   t h e   e x a m p l e   t o o l b a r   s c r i p t s 
 	 3 0 - O C T - 2 0 0 1 :   N o w   h a n d l e s   e m b e d d e d   s i n g l e   q u o t e   c h a r a c t e r s   i n   f i l e   n a m e s 
 	 3 0 - O C T - 2 0 0 1 :   N o w   h a n d l e s   f o l d e r s   o n   v o l u m e s   o t h e r   t h a n   t h e   s t a r t u p   v o l u m e 
 	 3 0 - O C T - 2 0 0 1 :   N o w   h a n d l e s   c l i c k   o n   i c o n   i n   t o p - l e v e l   ( m a c h i n e )   w i n d o w 
 	 3 1 - O C T - 2 0 0 1 :   N o w   d i s p l a y s   a   n i c e r   t e r m i n a l   w i n d o w   t i t l e ,   c o u r t e s y   o f   A l a i n   C o n t e n t 
 	 1 1 - N O V - 2 0 0 1 :   N o w   f o l d e r s   w i t h i n   a p p l i c a t i o n   p a c k a g e s   ( . a p p   d i r e c t o r i e s )   a n d   h a s   a   n e w   i c o n 
 	 1 2 - N O V - 2 0 0 1 :   N e w   p r o p e r t i e s   t o   s e t   t e r m i n a l   c o l u m n s   a n d   r o w s   a s   t h e   T e r m i n a l   d o e s   n o t   u s e   d e f a u l t   s e t t i n g s 
 	 1 4 - N O V - 2 0 0 1 :   M a j o r   c h a n g e ,   n o w   h a n d l e s   8 - b i t   c h a r a c t e r s   i n   a l l   s h e l l s ,   a n d   q u o t e s   a n d   s p a c e s   i n   t c s h 
 	 1 8 - N O V - 2 0 0 1 :   V e r s i o n   1 . 1 :   R e w r i t e ,   n o w   u s e s   a   t e m p o r a r y   f i l e     ~ / . O p e n T e r m i n a l H e r e   t o   c o m m u n i c a t e 
 	                           t h e   d i r e c t o r y   n a m e   b e t w e e n   A p p l e S c r i p t   a n d   t h e   s h e l l   b e c a u s e   t h i s   i s   m u c h   m o r e   r e l i a b l e   f o r   8 - b i t   c h a r a c t e r s 
 	 1 6 - J A N - 2 0 0 6 :   V e r s i o n   2 . 0 :   R e w r i t e ,   n o w   u s e s   " q u o t e d   f o r m   o f "   a n d   " P O S I X   P a t h " .   T h i s   g e t s   r i d   o f 
 	                           P e r l   a n d   t e m p   f i l e s ,   b u t   i t   n o   l o n g e r   h a n d l e s   f i l e s   i n s t e a d   o f   f o l d e r s . 
 	 2 4 - J A N - 2 0 0 7 :   V e r s i o n   2 . 1 :   I n t e g r a t e d   e n h a n c e m e n t s   b y   S t e p h a n   H r a d e k ,   c a n   a g a i n   h a n d l e   d r o p p e d   f i l e s . 
 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    . ( when the toolbar script icon is clicked     �   P   w h e n   t h e   t o o l b a r   s c r i p t   i c o n   i s   c l i c k e d      l     ��������  ��  ��        i         I     ������
�� .aevtoappnull  �   � ****��  ��    O     .    k    -       I   	������
�� .miscactvnull��� ��� null��  ��       !   l  
 
��������  ��  ��   !  " # " Q   
 $ $ % & $ r     ' ( ' c     ) * ) l    +���� + l    ,���� , n     - . - 1    ��
�� 
fvtg . l    /���� / 4   �� 0
�� 
cwin 0 m    ���� ��  ��  ��  ��  ��  ��   * m    ��
�� 
alis ( o      ���� 0 this_folder   % R      ������
�� .ascrerr ****      � ****��  ��   & r    $ 1 2 1 1    "��
�� 
sdsk 2 o      ���� 0 this_folder   #  3 4 3 l  % %��������  ��  ��   4  5 6 5 n  % + 7 8 7 I   & +�� 9���� 0 process_item   9  :�� : o   & '���� 0 this_folder  ��  ��   8  f   % & 6  ;�� ; l  , ,��������  ��  ��  ��    m      < <�                                                                                  MACS  alis    2  macOS                          BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    m a c O S  &System/Library/CoreServices/Finder.app  / ��     = > = l     ��������  ��  ��   >  ? @ ? l     ��������  ��  ��   @  A B A l     ��������  ��  ��   B  C D C l     �� E F��   E J D This handler processes folders dropped onto the toolbar script icon    F � G G �   T h i s   h a n d l e r   p r o c e s s e s   f o l d e r s   d r o p p e d   o n t o   t h e   t o o l b a r   s c r i p t   i c o n D  H I H l     ��������  ��  ��   I  J K J i     L M L I     �� N��
�� .aevtodocnull  �    alis N o      ���� 0 these_items  ��   M X      O�� P O n    Q R Q I    �� S���� 0 process_item   S  T�� T o    ���� 0 	this_item  ��  ��   R  f    �� 0 	this_item   P o    ���� 0 these_items   K  U V U l     ��������  ��  ��   V  W X W l     ��������  ��  ��   X  Y Z Y l     ��������  ��  ��   Z  [ \ [ l     �� ] ^��   ] + % this subroutine does the actual work    ^ � _ _ J   t h i s   s u b r o u t i n e   d o e s   t h e   a c t u a l   w o r k \  ` a ` l     ��������  ��  ��   a  b c b i     d e d I      �� f���� 0 process_item   f  g�� g o      ���� 0 	this_item  ��  ��   e k     7 h h  i j i r      k l k n      m n m 1    ��
�� 
psxp n o     ���� 0 	this_item   l o      ���� 0 the_path   j  o p o W      q r q r     s t s n     u v u 7   �� w x
�� 
ctxt w m    ����  x m    ������ v o    ���� 0 the_path   t o      ���� 0 the_path   r D   
  y z y o   
 ���� 0 the_path   z m     { { � | |  / p  }�� } O   ! 7 ~  ~ k   % 6 � �  � � � I  % *������
�� .miscactvnull��� ��� null��  ��   �  ��� � I  + 6���� �
�� .coredoscnull    ��� null��   � �� ���
�� 
cmnd � b   - 2 � � � m   - . � � � � �  c d   � n   . 1 � � � 1   / 1��
�� 
strq � o   . /���� 0 the_path  ��  ��    m   ! " � ��                                                                                  trmx  alis    .  macOS                          BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   &/:Applications:Utilities:Terminal.app/    T e r m i n a l . a p p    m a c O S  #Applications/Utilities/Terminal.app   / ��  ��   c  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � l     ��������  ��  ��  ��       �� � � � � �������   � ������~�}�|
�� .aevtoappnull  �   � ****
�� .aevtodocnull  �    alis� 0 process_item  �~ 0 this_folder  �}  �|   � �{ �z�y � ��x
�{ .aevtoappnull  �   � ****�z  �y   �   � 
 <�w�v�u�t�s�r�q�p�o
�w .miscactvnull��� ��� null
�v 
cwin
�u 
fvtg
�t 
alis�s 0 this_folder  �r  �q  
�p 
sdsk�o 0 process_item  �x /� +*j O *�k/�,�&E�W X  *�,E�O)�k+ 	OPU � �n M�m�l � ��k
�n .aevtodocnull  �    alis�m 0 these_items  �l   � �j�i�j 0 these_items  �i 0 	this_item   � �h�g�f�e
�h 
kocl
�g 
cobj
�f .corecnte****       ****�e 0 process_item  �k  �[��l kh )�k+ [OY�� � �d e�c�b � ��a�d 0 process_item  �c �` ��`  �  �_�_ 0 	this_item  �b   � �^�]�^ 0 	this_item  �] 0 the_path   � 
�\ {�[�Z ��Y�X ��W�V
�\ 
psxp
�[ 
ctxt�Z��
�Y .miscactvnull��� ��� null
�X 
cmnd
�W 
strq
�V .coredoscnull    ��� null�a 8��,E�O h���[�\[Zk\Z�2E�[OY��O� *j O*���,%l 	U �balis    ^  Macintosh HD               �> �H+   J�misc                                                            Jå��?        ����  	                Docs    �=�      ��?     J� JR� �� �  0Macintosh HD:Users: alcides: Dropbox: Docs: misc  
  m i s c    M a c i n t o s h   H D  Users/alcides/Dropbox/Docs/misc   /    ��  ��  ��  ascr  ��ޭ