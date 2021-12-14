#!/usr/bin/perl

use Term::ANSIScreen qw/:color :cursor :screen :keyboard/;
use Term::ReadKey;

my @C = ('','=','=','=','=','=','=','=');
my @XD = (0, 9, 25, 41);
my (@A);
my ($I);
my ($T,$F,$N);
my ($K);

sub Update() {
 my ($J, $X, $Y, $Z);
 $I = 0;
 for($Y = 15;$Y >= 8; $Y--) {
   $I++;
   for($X = 1; $X <= 3; $X++) {
	$Z = $A[$X][$I];
	if($Z == 0) {
	 locate $Y, $XD[$X] - 7;
	 print ' ' x 6,'¦',' ' x 6;
	} else {
	 for($J = $XD[$X] - $Z; $J < $XD[$X] + $Z; $J++) {
	  locate $Y, $J;
	  print $C[$Z];
	 }
	}
   }
 }
}

sub ChkOk($) {
 my($R) = @_;
  $I = $K;
  if($I =~ m/(1|2|3)/) {
   if($R == 1) {
	$F = $I;
   } else {
	$T = $I;
   }
   print $K;
   locate 20, 10;
   print ' ' x 30;
  } else {
   locate 20, 10;
   print 'Répondre 1, 2 ou 3 S.V.P.';
   return 0;
  }
 return 1;
}

for(my $J = 0; $J <= 3; $J++) {
   for(my $I = 0; $I <= 8; $I++) {
	  $A[$J][$I] = 0;
   }
}
$N = 1;
$A[2][0] = 7;
for($I = 1; $I <= 7; $I++) {
 $A[2][$I] = 8 - $I;
}

cls;
locate 1, 13;
print 'Tours d\'Hanois';
locate 16, 1;
color('BLACK ON_GREEN');
print ' 'x 8,'1',' ' x 14,'2',' ' x 14,'3',' ' x 8;
color('WHITE ON_BLACK');

do {
  Update();
  locate 18, 1;
  print 'Coup:',$N;
  clline;
  locate 18, 12;
  print 'Votre Jeu - De:';
  do {
   locate 18, 27;
   ReadMode 4;
   $K = &ReadKey();
   ReadMode 0;
   if($K eq 'q') {
	 exit();
   }
  } until (ChkOk(1));
  locate 18, 30;
  print ' à:';
  do {
   locate 18, 33;
   ReadMode 4;
   $K = &ReadKey();
   ReadMode 0;
   if($K eq 'q') {
	 exit();
   }
  } until (ChkOk(2));
  locate 20, 10;
  my $Ok = 1;
  if($A[$T][0] != 0) {
   unless (($A[$F][0] > 0) && ($A[$F][$A[$F][0]] < $A[$T][$A[$T][0]])) {
	print 'Coup illégal! Recommencez';
	$Ok = 0;
   }
  } else {
   print ' ' x 30;
  }
  if($Ok) {
   $A[$T][0]++;
   $A[$T][$A[$T][0]] = $A[$F][$A[$F][0]];
   $A[$F][$A[$F][0]] = 0; $A[$F][0]--; $N++;
   if(($A[1][0] == 7) || ($A[3][0] == 7)) {
	Update();
	locate 19, 1;
	print 'Félicitations - Il t\'a fallu ',$N-1,' coups';
	exit();
   }
  }
} until 0 != 0;

