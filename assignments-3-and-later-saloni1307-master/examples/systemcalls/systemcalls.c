#include "systemcalls.h"
#include <errno.h>

/**
 * @param cmd the command to execute with system()
 * @return true if the commands in ... with arguments @param arguments were executed 
 *   successfully using the system() call, false if an error occurred, 
 *   either in invocation of the system() command, or if a non-zero return 
 *   value was returned by the command issued in @param.
*/
bool do_system(const char *cmd)
{

/*
 * TODO  add your code here
 *  Call the system() function with the command set in the cmd
 *   and return a boolean true if the system() call completed with success 
 *   or false() if it returned a failure
*/
    int sys=0;

    sys=system(cmd);    //call system() to execute the command as a child process

    if(sys==0) 
    {
	    return true;    //return true if execution successful
    }

    return false;       //return false on unsuccessful execution
}

/**
* @param count -The numbers of variables passed to the function. The variables are command to execute.
*   followed by arguments to pass to the command
*   Since exec() does not perform path expansion, the command to execute needs
*   to be an absolute path.
* @param ... - A list of 1 or more arguments after the @param count argument.
*   The first is always the full path to the command to execute with execv()
*   The remaining arguments are a list of arguments to pass to the command in execv()
* @return true if the command @param ... with arguments @param arguments were executed successfully
*   using the execv() call, false if an error occurred, either in invocation of the 
*   fork, waitpid, or execv() command, or if a non-zero return value was returned
*   by the command issued in @param arguments with the specified arguments.
*/

bool do_exec(int count, ...)
{
    va_list args;
    va_start(args, count);
    char * command[count+1];
    pid_t fork_ret;
    int wait_ret=0;
    int i, status;

    for(i=0; i<count; i++)
    {
	     command[i] = va_arg(args, char *);  //store the function arguments in an array
    }
    command[count] = NULL;

/*
 * TODO:
 *   Execute a system command by calling fork, execv(),
 *   and wait instead of system (see LSP page 161).
 *   Use the command[0] as the full path to the command to execute
 *   (first argument to execv), and use the remaining arguments
 *   as second argument to the execv() command.
 *   
*/

    fork_ret = fork();      //fork a process
    if(fork_ret==-1)
    {
	     perror("fork");
	    return false;
    }

    else if(fork_ret==0)
    {
	     execv(command[0], &command[0]);    //execute the command passed using execv
	     perror("execv");
	     exit(-1);      //exit child process if execv call failed
    }

    wait_ret = waitpid(fork_ret, &status, 0);   //wait for process status change
    if(wait_ret==-1)
    {
	    perror("waitpid");
	    return false;
    } 
 
    else if(WIFEXITED(status))
    {
	    //check if system exited
	    int exit_status=WEXITSTATUS(status);
	    if(exit_status!=0)                      //check the process exit status
		    return false;                       //return false if process failed
    }

    va_end(args);

    return true;
}

/**
* @param outputfile - The full path to the file to write with command output.  
*   This file will be closed at completion of the function call.
* All other parameters, see do_exec above
*/
bool do_exec_redirect(const char *outputfile, int count, ...)
{
    va_list args;
    va_start(args, count);
    char * command[count+1];
    int i;
    for(i=0; i<count; i++)
    {
	    command[i] = va_arg(args, char *);      // store function arguments in an array
    }

    command[count] = NULL;
    // this line is to avoid a compile warning before your implementation is complete
    // and may be removed
    command[count] = command[count];


/*
 * TODO
 *   Call execv, but first using https://stackoverflow.com/a/13784315/1446624 as a refernce,
 *   redirect standard out to a file specified by outputfile.
 *   The rest of the behaviour is same as do_exec()
 *   
*/

    int kidpid, status;
    int wait_ret=0;
    int fd = open(outputfile, O_WRONLY|O_TRUNC|O_CREAT, 0644);  //open file to be redirected to 
    if (fd < 0)
    {
	    perror("open");
	    return false;
    }

    kidpid = fork();    //fork the parent process

    if(kidpid==-1) 
    {
	    perror("fork");
	    return false;
    }

    else if(kidpid==0) 
    {
	    if(dup2(fd, 1) < 0)     //assign a new file descriptor to the file previously opened
	    {
		    perror("dup2");
		    return false;
	    }

	    close(fd);              //close the old file descriptor
	    execv(command[0], command); //execute the child process
	    perror("execv");
	    exit(-1);
    }

    wait_ret = waitpid(kidpid, &status, 0);     //wait for status change of child process

    if(wait_ret==-1) 
    {
	    perror("waitpid");
	    return false;
    }

    else if(WIFEXITED(status)) 
    {
	    int exit_status=WEXITSTATUS(status);    //check exit status of the child process
	    if(exit_status!=0) 
	    {
		    return false;
            }
    }

    va_end(args);
    
    return true;
}
