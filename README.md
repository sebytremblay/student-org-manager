# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Project Overview & Instructions

This application is a management system for student organizations on campus. It specifically supports club sports teams and Greek Life organizations. Members of the organizations can see upcoming events, directories of their organization, etc. Admins can manage their groups through creating new events, adding/deleting members, managagin dues, etc. Prospective members can see a list of all available organizations and browse their public homepages.

In order to start this application, first clone the repositoy. Once the app is cloned, navigate to the ./secrets file. There, create two files, `db_password.txt` and `db_root_password.txt`. In each of them, write a password at least one character long to instantiate the database with. Then, run `docker compose up -d` to launch the containers.

Once the backend is running, you must create an authenticated version of the frontend. Navigate to the frontend repository [here](https://github.com/Niklex21/cs3200-student-org-appsmith). Fork the repository to give yourself admin access. You do not need to clone or download this repository.

Once the containers are loaded and the frontend repository is initialized, navigate to `localhost:8080`. Fill in user credentials if necessary and navigate to the homepage. There, in the top right corner, click the `Create New` button and select `Import`. Choose `Import from Git Repository`, select `GitHub`, and check the `I have an existing Appsmith App connected to Git`. Then, follow the instructions to finish importing the repository. Once you have successfully imported the repository, you will be brought to the home page. In the bottom select, ensure to navigate to the `Release` branch. Now, you are all set!

## Final Video Submission

Our video is viewable at: 

    https://drive.google.com/file/d/1EZQ_hnA3zRqlPYCgZbjsNhjOsHIhvuYO/view?usp=sharing