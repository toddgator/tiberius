#!/bin/bash
##
##
##
## SSH Key last rotated 6/1/16 on conference call with Todd Smith and 
## Lisa A. Jenkins
## System Support Analyst, Transmission Support Services, 2nd Level Support
## TMT Treasury Management Technology
## Wells Fargo Wholesale Services Group | 1305 West 23rd Street | Tempe, AZ 85282
## Tel 480-437-7965 | Fax 480-437-8331 | MAC S4005-028
## Transmission Support Hotline:  800-835-2265    x75555
## Lisa.Jenkins2@wellsfargo.com
##
## Wellsfargo transfers in files to THIG daily
useradd wellsfargo
ssh-keygen -t rsa
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCG8hp9rmtGxRyl+yFxnAKQzgwrUQ+X76agLYX0k5SjCAG6sHMQZ/sef9bG3/oXG9PU8mLNYSMAYuYjn/wkeaFtEfuHz9R8ePc6zavUFvN3AOYpQJrA/SsKEIztYTyxL0fKQ/0gLw5oSfJhgiXETKU1XZ8HK/uK6FPxjwbSVRkUbzHPr5hEWunasgPxdghNwOTzA9phzmSW1+DVc1YiA3OPNz53iR7pedBFhgEfdxP1+uVAT/Nm5httgu9KYBKYhPalD6N6Q0WhlZU2vO0u0VoN8GfNVn3Nm2VKaGkg0sA59j49kI2B07Zp1BhbpZdSAiymsdUcYxyB2sHGqLf+ddTz' >> /home/wellsfargo/.ssh
