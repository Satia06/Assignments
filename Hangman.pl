#!/use/local/bin/perl
#given array of words from which to be guess word is choosen 
@words = ("computer","radio","calculator" ,"teacher","bureau","police","geometry","president","subject","country","enviroment","classroom","animals","province","month","politics","puzzle","instrument","kitchen","language",
"vampire","ghost","solution","service","software","virus25","security","phonenumber","expert","website","agreement","support","compatibility","advanced","search","triathlon","immediately","encyclopedia","endurance","distance","nature","history","organization","international","championship","government",
"popularity","thousand","feature","wetsuit","fitness","legendary","variation","equal","approximately","segment","application","prediction","reference","measurement","algebra","toxic","dimension","classic","verification","unusual","resource|","citation","screenplay","director","release","aircraft",
"priority","physics","branches","science","mathematics","lightning","dispersion","accelerator","detector","terminology","design","operation","foundation","symmetry","airplane","comedy","license","operation","design","concept","perspective","overview","position","analysis","illustration","production",
"emphasis","trademark","vehicle","experiment");
#Array to store already guessed words.
@guesses = ();
# how many times the player has tried 
#Hangman Display part 
sub HangmanDisplay{
    $wrong = shift;# wrong is passed as a parameter.
    #On the basis of this wrong, hangman state is changed
    #I choosed a hangman which is has length 6 
    #i-e a player can make 6 maximum wrong guesses.
    #after that the hangman will be complete and game will terminate
    #print("$wrong \n");
    print("  |-----\n");
    print("  |    |\n");
    #for wrong greater than or equal to 1 i-e made one guess wrong 
    if($wrong >= 1){
        print("  |    O\n");
    }
     #wrong is 0 or less than 1 i-e no wrong guess
    else{
        print("  |  \n");
    }
    #number of wrong guesses 2 
    #it also checks if its less than 2 and then the state of hangman will be different 
    if($wrong == 2){
        print("  |    |\n");
        print("  |    |\n");
    }
    elsif($wrong < 2){
        print("  |  \n");
        print("  |  \n");
    }
    #similarly for the guesses made 
    #it will check which state of hangman will be displayed depending on wrong which can be 0 to 1 
    # 0 will be normal state or in real world it will be stand of the hangman
    #while rest will be show the parts of hangman 
    else{
        if($wrong == 3){
            print("  |   /|\n");
        }
        else{
            print("  |   /|\\ \n");
        }
        print("  |    |\n");
    }
    
    if($wrong == 5){
        print("  |   /  \n");
    }
    elsif($wrong == 6){
        print("  |   / \\ \n");
    }
    else{
        print("  |  \n");
    }
    print("  |  \n");
    print("  |\n");

    print("\n");    
}
# to count the times of varible has been repeated it ususally keeps value as 0 and 1 if 0 then not repeated.
$times = 0; 
# main part of the code 
# without a hangman wersion 
$choices = $words[rand @words];  #rand function is an inbuilt function which randomly chooses a word from the given array 
#it can be used to choose a number as well 
# $choices contain that word(secret word)
$size = length($choices);  # length of the word; for displaying the dash that is -----
@letters=split(//, $choices); # this line splits the choosen word in $choices.
#for example let the word be computer; it will split the word "computer" and store it in @letters.
# @blankword contains these splitted letter in form of 0's upto the length of the secret Word
#later in the code we change it to the required letter or guessed lettr at the same position to that of secret word.
@blankword=(0) x scalar(@letters);
#varible to see if won or not.
$won = 0;
#  It has a label—OUTER—so that inside the loop you can have some fine-grained control over it. 
OUTER:
    print("Bonjour to the Word-guessing game: Hangman\n");
    
    #game loop 
    while(1){
        #print("The word is: $choices \n"); # for reference
        while($wrong < 6 && $won == 0){
            #For checking whether word is completely guessed right or hangman number that is wrong guess exceed 6 times.
            #in both the above conditions it will terminate and display the corresponding messages 
            print("Here is your word:");
            #printing the ----- dashes same as length of the word
            #here i replaced the 0's in @blankword with dash "-" and print it
            foreach $i (0..$#letters) {
    	        if ($blankword[$i]) {
    	            print $blankword[$i];
    	        } 
    	        else {
    		        print "-";
    	        }
    	    }
    	    print("\n");
    	    #Displaying the hangman initial state
            HangmanDisplay($wrong);
            # if($wrong) {
    	   #     HangmanDisplay($wrong);
    	   # }
    	   #printing the guesses array to see the letters you have already guessed.
            print("Guesses made so far: @guesses\n");
            #taking the input or player will enter the letter 
            print("Make a guess: ");
            #input and chomp helps in removing the newline in the input.
            $guess = <STDIN>; chomp $guess;
            #checking whether the guessed letter is already guessed or not?
            foreach(@guesses) {
                if ($_ eq $guess){  # every element will be compared with the guess letter
                    print("Sorry, it's already guessed. Guess some other letter.\n");
                    $times++;
                    last; # like break it will help to print the alredy guessed once only 
                }
    	    }
    	   #$guesses[@guesses]=$guess;
    	   #Comparing the guessed letter if its in the choosen word or not. If yes then it will add if wrong it will change the state
    	   #of hangman 
    	    push(@guesses, $guess);
    	    $right=0;
    	    for ($i=0; $i<@letters; $i++) {
    	        if ($letters[$i] eq $guess) {
    		        $blankword[$i]=$guess;
    		        $right=1;	 
    	        }
    	    }
    	    #here checking if its not right 
    	    # then see if the times varible 
    	    #if its 0 then increment 
    	    # otherwise dont and change the times varibel to 0.
    	    if(not $right){
    	        if($times == 0){
    	            ++$wrong;
    	        }
    	        else{
    	            $times = 0;
    	        }
    	    }
    	    #After joining all the words if its same as choosen word then say yes player won
    	    if (join('', @blankword) eq $choices) {
    	        print("The word is $choices\n");
    	        print("You got it right!\n");
    	        $won = 1;
            }
        }
        #if its not guessed right and guesses made are more than 6 then player lose.
        if($wrong >= 6){
            HangmanDisplay($wrong);
            print("Better Luck Next time!!\n");
            print("The word was $choices.\n");
        }
        #for one more game 
        #if the player wants to play more 
        #then again same procedure of choosing, input is done and game proceeds.
        print("Would you like to play again? [y/n] \n");
        $inp = <STDIN>; chomp $inp;
        if($inp eq 'y'){
            $wrong = 0;
            $won = 0;
            $choices = $words[rand @words];
            $size = length($choices);
            @letters=split(//, $choices);
            @blankword=(0) x scalar(@letters);
            @guesses = ();
            next;
        }
        #if not then have a good day 
        elsif($inp eq 'n'){
            print("Have a Good Day:)\n");
            print("Thank you for playing.\n");
            exit;
        }
        else{
            print("Invalid choice \n");
        }
    }
