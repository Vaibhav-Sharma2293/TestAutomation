*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem

*** Variables ***

${URL}                  https://www.google.com/
${driver}               chrome
${googleText}           xpath=//input[@name='q']
${googleButton}         xpath=//input[@name='btnK']
${robotLinks}           xpath=//span[@jsname='czHhOd']/ancestor::*[@class='yuRUbf']
${robotResult}          xpath=//a//h3[contains(text(),'Robot')]
${filePath}             ${EXECDIR}/Resources/output.txt

*** Test Cases ***

Print google search result/links
        Open Browser  ${URL}  ${driver}
        maximize browser window
        wait until element is visible  ${googleText}
        Enter text on google text field
        wait until element is visible  ${googleButton}
        capture page screenshot
        Click on google search button
        wait until element is visible  ${robotLinks}
        capture page screenshot
        Print the Elements in console and text file
        close browser

*** Keywords ***

Enter text on google text field
     input text          ${googleText}  robotframework

Click on google search button
    click element       ${googleButton}

Print the Elements in console and text file
    @{Links}=  Get WebElements  ${robotLinks}
    create file    ${filePath}
    FOR   ${elementLinks}  IN   @{Links}
        ${resultText}=    get text    ${elementLinks}
        Log  ${resultText}${\n}
        log to console  ${resultText}${\n}
        append to file  ${filePath}    ${resultText}${\n}    encoding=UTF-8
    END
