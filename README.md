# cloud.resume.challenge

This was inspired by the cloud resume challenge and hosts my resume using a modern web development stack.

This website is put together with the following:

- Terraform to manage all of the infrastructure
- ACM for certificate management
- S3 for the static hosting of the website
- Cloudfront to serve the site
- DynamoDB to keep a count of website visitors
- A python lambda function to increment the dynamoDB
- An API gateway to interface between the app and the backend
- Javascript for the website counter
- A frontend and backend CI/CD process utilizing Github Actions that tests and deploys the python, as well as updates the website as needed

