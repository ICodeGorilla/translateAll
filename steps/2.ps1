# Step 2: Create Application (step2.ps1)

# Check if the step has been applied
if ((Get-Content -Path .\progress.log -ErrorAction SilentlyContinue) -like "*step2 applied*") {
    Write-Output "Step 2 has already been applied."
} else {
    # Create a new Angular project
    ng new obs-live-translation --skip-git --skip-install

    # Navigate to the project directory
    Set-Location -Path .\obs-live-translation\

    # Install necessary packages
    npm install @angular/http

    # Create a new component for the translation feature
    ng generate component live-translation

    # Update live-translation.component.ts file
    $componentTsContent = @"
import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import * as config from '../config.json';

@Component({
  selector: 'app-live-translation',
  templateUrl: './live-translation.component.html',
  styleUrls: ['./live-translation.component.css']
})
export class LiveTranslationComponent implements OnInit {
  translation: string;

  constructor(private http: HttpClient) { }

  ngOnInit() {
    // Initialize the speech recognition service
    let recognition = new webkitSpeechRecognition();
Continuing from the previous message:

```powershell
    recognition.onresult = (event) => {
      // Get the speech result
      let speechResult = event.results[0][0].transcript;

      // Translate the speech result
      this.http.get(`https://translation.googleapis.com/language/translate/v2?key=${config.googleTranslateApiKey}&source=en&target=es&q=${speechResult}`).subscribe(response => {
        // Display the translation
        this.translation = response.data.translations[0].translatedText;
      });
    };

    // Start the speech recognition service
    recognition.start();
  }
}
"@
    $componentTsContent | Out-File -FilePath .\src\app\live-translation\live-translation.component.ts -Encoding utf8

    # Update live-translation.component.html file
    $componentHtmlContent = @"
<div>
  <p>{{ translation }}</p>
</div>
"@
    $componentHtmlContent | Out-File -FilePath .\src\app\live-translation\live-translation.component.html -Encoding utf8

    # Mark the step as applied
    Add-Content -Path ..\progress.log -Value "step2 applied"
}
