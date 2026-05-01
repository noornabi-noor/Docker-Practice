FROM node:20-alpine 
# node:20-alpine -> This is a lightweight version of the Node.js image based on Alpine Linux. 
# It is optimized for size and security, making it ideal for running Node.js applications in a containerized environment. 
# The "20" indicates the version of Node.js included in the image, which is version 20.x.x. 
# Using an Alpine-based image helps reduce the overall size of the Docker image while still providing 
# the necessary runtime environment for Node.js applications.

WORKDIR /app
# WORKDIR /app -> This command sets the working directory inside the Docker container to "/app". 
# This means that any subsequent commands (like COPY, RUN, etc.) will be executed in the context of this directory. 
# It helps organize the application files and ensures that the container's file system is structured 
# in a way that is easy to manage. By setting the working directory to "/app", you can easily copy 
# your application files into this directory and run your application from there.

ENV NODE_ENV=production
# ENV NODE_ENV=production -> This command sets an environment variable named "NODE_ENV" to "production". 
# This is useful for configuring the application to run in a production environment, where certain optimizations 
# and behaviors may differ from a development environment.

COPY package*.json ./
# COPY package*.json ./ -> This command copies both "package.json" and "package-lock.json" 
# (where the Dockerfile is located) into the current working directory ("/app") inside the Docker container. 
# The "package.json" file is essential for Node.js applications as it contains metadata about the project, 
# including its dependencies and scripts. By copying this file first, you can run "npm install" to install 
# the necessary dependencies before copying the rest of the application files, which can help optimize 
# the build process by leveraging Docker's caching mechanism.

RUN npm ci --only=production
# RUN npm ci --only=production -> This command installs the dependencies listed in the "package.json" file using 
# the "npm ci" command, which is designed for clean and reproducible builds

COPY . .
# COPY . . -> This command copies all the files and directories from the current directory on the host machine 
# (where the Dockerfile is located) into the current working directory ("/app") inside the Docker container. 
# This includes your application code, configuration files, and any other necessary resources. 
# By copying all the files after installing dependencies, you can take advantage of Docker's layer caching, 
# which can speed up subsequent builds if there are no changes to the dependencies.

EXPOSE 5000
# EXPOSE 5000 -> This command informs Docker that the container will listen on port 5000 at runtime. 
# It does not actually publish the port to the host machine; instead, 
# it serves as documentation for users of the image and can be used by Docker when running the container to map ports.
#  When you run the container, you can use the "-p" flag to map this internal port to a port on the host machine, 
# allowing external access to the application running inside the container.

CMD ["node", "index.js"]
# CMD ["node", "index.js"] -> This command specifies the default command to run when the container starts. 
# In this case, it tells Docker to execute "node index.js", which is the main entry point for the Node.js application. 
# This command typically starts the Node.js application, allowing it to run and listen for incoming requests. 
# By using CMD, you can ensure that your application will automatically start when the container is launched 
# without needing to specify the command each time.
