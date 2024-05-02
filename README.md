# CMPT370



## Team Members for CMPT 370 Zooming Zoomers

| Member # | Name | NSID |
| --- | ----------- | ----- | 
| 1 | Alex Chen | alc292 |
| 2 | Brix Marcellana | bem346 |
| 3 | Vu Nguyen | vun786|
| 4 | Jesse Aguirre | jaa369 |
| 5 | Showvik Mazumdar | shm959 |



## Add your files

- [ ] [Create](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#create-a-file) or [upload](https://docs.gitlab.com/ee/user/project/repository/web_editor.html#upload-a-file) files
- [ ] [Add files using the command line](https://docs.gitlab.com/ee/gitlab-basics/add-file.html#add-a-file-using-the-command-line) or push an existing Git repository with the following command:


```
cd existing_repo
git remote add origin https://git.cs.usask.ca/jaa369/cmpt370.git
git branch -M main
git push -uf origin main
```

### Development Process

1. Fetch latest changes from main repository:

   ```sh
   git fetch upstream
   ```

2. Reset your fork's `main` branch to exactly match upstream `main`:

   ```sh
   git checkout main
   git reset --hard upstream/trunk
   git push --force
   ```

   **IMPORTANT**: Do this only once, when you start working on new feature as
   the commands above will completely overwrite any local changes in `main` content.
3. Edit, edit, edit, and commit your changes to Git:

   ```sh
   # edit, edit, edit
   git add *
   git commit -m 'A useful commit message'
   git push
   ```

## Product Description

- The main product that Zooming Zoomers aims to build is a digital flight log for paramotorists with many tools that ensure a safe and enjoyable flight. Currently this is a wide open market in Saskatoon as the paramotoring community is just beginning to grow into a promising entry-point for our technology.

## Opportunity and Value

-  Currently, the paramotoring community tends to rely on physical logbooks and their memory to record their flight info that helps them diagnose problems with their equipment, check fuel levels before their flight, and ensure that the follow the correct safety procedures before every flight. This lack of an organized solution can lead to many safety issues and concerns if people neglect or forget to keep track of their equipment and its condition. This problem can be fatal if left ignored and we believe that if we introduced an automated process for these tasks with the deployment of a mobile app then we could simplify and streamline the process. In doing so, we hope that our app can prevent unnecessary accidents that could potentially claim lives if left ignored.


## Stakeholders

-  Our main target market right now consists of the Saskatoon paramotoring community, our very own team member Alex came up with this idea as a paramotorist himself so it is good to have a developer with fresh eyes as someone who partakes in this thrilling activity. A successful project could mean that we have an advantage over other app developers as there are no implementations that we know of after doing research on existing technologies. This means that our app will grow as more and more people join this sport.

# Technologies

- We plan to use Java as our implementation language as well as the Java Collections Framework for storage of data. For later authentication features and backend we are planning to use mySQL to build our own database for data storage. Our early work will deal with Figma for wireframing an UI that feels responsive to the user and later own will use Java Fx (tentatively).

## Product Installation Instructions
Specifically For Windows in an Android phone:  

	Flutter Installation:  

		1.) Download the zip located at https://docs.flutter.dev/get-started/install/windows  

		2.) Extract the zip file into the desired folder (example C:\src\flutter).  

		3.) Search 'env' in the search bar and Open the environment variables menu.  

		4.) Under User Variables check if there is an entry called Path:  

			- If Path exist, append the full path to 'flutter/bin' using ';' as a separator from existing vlaues  

			- If Path does not exist, create a new user variable named Path with the full path to 'flutter\bin' as its value.  

		5.) From the extracted flutter files, run the flutter console.  

		6.) Run the command 'flutter doctor' to install flutter.  

	Android Studios:  

		1.) Go to https://developer.android.com/studio and click download android studio.  

		2.) In the 'Android studio setup wizard', install the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, 
			which are required by Flutter when developing for Android.  

		3.) Rerun the 'flutter doctor' command in the flutter console to confirm that flutter has located the installation of Android studios.  

	Set up Android Device:  

		1.) Enable Developer options in the settings menu the phone. Turn on USB debugging on your device.  

		2.) Using a USB cable, plug your phone into your computer.  

		3.) If prompted on your device, authorize your computer to access your device.  

	Downloading the paramotor program:  

		1.) Go to our group zooming zoomers repository https://git.cs.usask.ca/jaa369/cmpt370.  
		
		2.) Clone the main branch into a folder of choice.  

		3.) Open the folder as a project in the Android Studios.  

		4.) If the dependency warning pops up at the top, click upgrade dependencies.  
		
		5.) Set main.dart as the targeted file to run.  

		6.) Run the main.dart and wait until Login menu opens in the android device.  
		
