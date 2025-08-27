pipeline {
  agent any  // run on the built-in node for this POC

  tools { ant 'Ant_1.10' }  // if you registered it in Jenkins Tools; else remove

  environment {
    DLC  = 'C:\\Progress\\OpenEdge'                 // adjust to your OE 12.8
    PATH = "${env.DLC}\\bin;${env.PATH}"            // put prowin/probatch on PATH (not required to compile, but handy)
  }

  options { timestamps() }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Verify PCT present') {
      steps {
        powershell '''
          if (!(Test-Path "lib\\pct")) { New-Item -ItemType Directory -Force -Path "lib\\pct" | Out-Null }
          $pct = Get-ChildItem "lib\\pct\\PCT*.jar","lib\\pct\\PCT.jar" -ErrorAction SilentlyContinue
          if (-not $pct) { throw "PCT jar not found in lib\\pct. Place PCT.jar from GitHub Releases there." }
          Write-Host "Found PCT: $($pct.Name)"
        '''
      }
    }

    stage('Compile (PCT/Ant)') {
      steps { bat 'ant -noinput -buildfile build.xml compile' }
    }

    stage('Package') {
      steps { bat 'ant -noinput -buildfile build.xml dist' }
    }

    stage('Archive Artifacts') {
      steps { archiveArtifacts artifacts: 'dist/rcode.zip, build/listing/**/*.lst', fingerprint: true }
    }
  }
}
