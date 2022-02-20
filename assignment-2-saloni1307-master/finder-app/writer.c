/* Assignment 2 - AESD       
 * writer.c
 * Author: Saloni Shah */

#include<stdio.h>
#include<string.h>
#include<syslog.h>
#include<stdlib.h>
#include<dirent.h>
#include<libgen.h>
#include<sys/time.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<errno.h>
#include<unistd.h>

int main(int argc, char *argv[] ) {

	int fd, wr, cs, statdir, mkdr;
	struct stat st = {0};
	char *dir;
	char path[200]="\0";
	char command[210]="\0";

	//open syslog for logging messages
	openlog("writer-log", LOG_PID, LOG_USER);
	
	//check if valid number of command line arguments are entered
	if(argc<3 || argc>3) {
		
		//log error message
		syslog(LOG_ERR, "Incorrect number of arguments. Received %d arguments instead of 2", argc-1);
		
		//print correct usage statement on terminal
		printf(	"USAGE:\n" "1 Path of file to be written to\n"
				"2 String to be written\n");
		printf("Error in Command line arguments\n");
		
		//exit upon receiving error
		exit(1);
	}
	
	//copy path argument entered in another string. (Because dirname() function will update the argv string)
	strcpy(path, argv[1]);

	//get the directory path 
	dir=dirname(argv[1]);

	//check if the directory exists
	statdir = stat(dir, &st);
	
	if(statdir == -1) {
		
		//make a new directory if directory does not exist
		sprintf(command,"mkdir -p %s", dir);
		mkdr = system(command);
	
		//in case of error in making the new directory show error message
		if(mkdr == -1) {
			printf("error in creating directory\n");
			syslog(LOG_ERR, "Could not make new directory");
			
			//exit upon receiving error
			exit(1);
		}
	}

	//now open the file specified in the argument
	fd = open(path, O_WRONLY|O_CREAT, 0777);
	if(fd == -1) {
		
		//log error message if file was not opened and exit
		syslog(LOG_ERR, "Could not open specified file");
		perror("File open:");
		exit(1);
	}

	//now write the specified string in opened file
	wr = write(fd, argv[2], strlen(argv[2]));
	if(wr == -1) {
		
		//log error message if string not written and exit
		syslog(LOG_ERR, "Could not write in specified file");
		perror("File write:");
		exit(1);
	}

	//close the file
	cs = close(fd);
	if(cs == -1) {
		
		//log error message if file not closed and exit
		syslog(LOG_ERR, "Could not close specified file");
		perror("File close:");
		exit(1);
	}

	//log debug message showing code execution complete
	syslog(LOG_DEBUG, "Writing %s to %s", argv[2], path);
	
	//close the log file
	closelog();
	return 0;
}
