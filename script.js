// Configuration
const GEMINI_API_KEY = "AIzaSyCm5ZHTze8i0HE1xP020uOwZQtu6hCeyLQ";
const GEMINI_API_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`;

// Mode Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    const modeToggle = document.getElementById('modeToggle');
    const body = document.body;
    
    // Check for saved mode preference or use dark mode as default
    const savedMode = localStorage.getItem('modePreference');
    if (savedMode === 'light') {
        body.classList.add('light-mode');
        updateToggleButton('light');
    } else {
        updateToggleButton('dark');
    }
    
    // Toggle mode on button click
    modeToggle.addEventListener('click', function() {
        body.classList.toggle('light-mode');
        
        if (body.classList.contains('light-mode')) {
            localStorage.setItem('modePreference', 'light');
            updateToggleButton('light');
        } else {
            localStorage.setItem('modePreference', 'dark');
            updateToggleButton('dark');
        }
    });
    
    function updateToggleButton(mode) {
        const icon = mode === 'dark' ? 'bi-moon-fill' : 'bi-sun-fill';
        const text = mode === 'dark' ? 'Dark Mode' : 'Light Mode';
        modeToggle.innerHTML = `<i class="bi ${icon}"></i> ${text}`;
    }
    
    // Loan Form Submission
    document.getElementById('loanForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        // Show loader
        const loader = document.getElementById('loader');
        const submitBtn = document.querySelector('.cosmic-btn');
        const btnText = submitBtn.querySelector('.btn-text');
        const btnSpinner = submitBtn.querySelector('.btn-spinner');
        
        loader.style.display = 'block';
        btnText.style.display = 'none';
        btnSpinner.style.display = 'inline-block';
        document.getElementById('resultContainer').style.display = 'none';
        
        // Get form values
        const formData = {
            name: document.getElementById('name').value,
            age: document.getElementById('age').value,
            income: document.getElementById('income').value,
            loanAmount: document.getElementById('loanAmount').value,
            employment: document.getElementById('employment').value,
            creditScore: document.getElementById('creditScore').value || 'Not provided'
        };
        
        try {
            // Call Gemini API
            const eligibilityResult = await checkLoanEligibility(formData);
            
            // Display results
            displayResults(eligibilityResult);
        } catch (error) {
            console.error('Error:', error);
            displayError();
        } finally {
            // Hide loader
            loader.style.display = 'none';
            btnText.style.display = 'inline-block';
            btnSpinner.style.display = 'none';
        }
    });
});

async function checkLoanEligibility(formData) {
    try {
        // Construct the prompt for Gemini
        const prompt = `Act as a loan eligibility checker for Indian banks. Analyze this application:

        Applicant Details:
        - Name: ${formData.name}
        - Age: ${formData.age}
        - Employment Type: ${formData.employment}
        - Monthly Income: ₹${formData.income}
        - Credit Score: ${formData.creditScore}
        
        Loan Request:
        - Amount: ₹${formData.loanAmount}
        
        Evaluation Guidelines:
        1. Age should be between 21-60 years
        2. Income to EMI ratio should be <= 50%
        3. Credit score should be >= 650 (if provided)
        
        Return response in this exact JSON format:
        {
            "eligible": boolean,
            "message": "string explaining decision",
            "improvementTips": ["array", "of", "suggestions"]
        }`;

        const requestBody = {
            contents: [{
                parts: [{
                    text: prompt
                }]
            }]
        };

        const response = await fetch(GEMINI_API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            throw new Error(`API request failed with status ${response.status}`);
        }

        const data = await response.json();
        
        if (!data.candidates || !data.candidates[0].content.parts[0].text) {
            throw new Error('Invalid response format from API');
        }
        
        // Extract the text response from Gemini
        const responseText = data.candidates[0].content.parts[0].text;
        
        // Try to parse the JSON response from Gemini
        try {
            const cleanResponse = responseText.replace(/```json|```/g, '');
            return JSON.parse(cleanResponse);
        } catch (e) {
            console.error('Failed to parse Gemini response:', e);
            console.log('Original response:', responseText);
            throw new Error('Failed to parse the eligibility response');
        }
    } catch (error) {
        console.error('Error in checkLoanEligibility:', error);
        throw error;
    }
}

function displayResults(result) {
    const resultContainer = document.getElementById('resultContainer');
    const resultAlert = document.getElementById('resultAlert');
    const resultTitle = document.getElementById('resultTitle');
    const resultMessage = document.getElementById('resultMessage');
    const improvementTips = document.getElementById('improvementTips');
    
    if (result.eligible) {
        resultAlert.className = 'alert alert-success cosmic-alert';
        resultTitle.textContent = 'Congratulations!';
        resultMessage.innerHTML = `<p>${result.message}</p><p>Our representative will contact you shortly.</p>`;
        improvementTips.innerHTML = '';
    } else {
        resultAlert.className = 'alert alert-danger cosmic-alert';
        resultTitle.textContent = 'Eligibility Check Failed';
        resultMessage.innerHTML = `<p>${result.message}</p>`;
        
        let tipsHtml = '<h5>To improve your eligibility:</h5><ul class="list-group">';
        result.improvementTips.forEach(tip => {
            tipsHtml += `<li class="list-group-item">${tip}</li>`;
        });
        tipsHtml += '</ul>';
        improvementTips.innerHTML = tipsHtml;
    }
    
    resultContainer.style.display = 'block';
}

function displayError() {
    const resultContainer = document.getElementById('resultContainer');
    const resultAlert = document.getElementById('resultAlert');
    const resultTitle = document.getElementById('resultTitle');
    const resultMessage = document.getElementById('resultMessage');
    const improvementTips = document.getElementById('improvementTips');
    
    resultAlert.className = 'alert alert-warning cosmic-alert';
    resultTitle.textContent = 'Error';
    resultMessage.textContent = 'There was an error processing your request. Please try again later.';
    improvementTips.innerHTML = '';
    
    resultContainer.style.display = 'block';
}

// Add these new functions to your script.js
function createConfetti() {
    const colors = ['#6B73FF', '#00D4FF', '#FF6B6B', '#4CAF50', '#FFD166'];
    const container = document.body;
    
    // Clear any existing confetti
    document.querySelectorAll('.confetti').forEach(el => el.remove());
    
    // Create 100 confetti pieces
    for (let i = 0; i < 100; i++) {
      const confetti = document.createElement('div');
      confetti.className = 'confetti';
      confetti.style.left = `${Math.random() * 100}vw`;
      confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
      confetti.style.animationDelay = `${Math.random() * 2}s`;
      confetti.style.width = `${Math.random() * 10 + 5}px`;
      confetti.style.height = confetti.style.width;
      
      // Random shapes
      if (Math.random() > 0.5) {
        confetti.style.borderRadius = '50%';
      } else {
        confetti.style.transform = `rotate(${Math.random() * 360}deg)`;
      }
      
      container.appendChild(confetti);
    }
  }
  
  function createFireworks() {
    const container = document.body;
    
    // Create 5 fireworks
    for (let i = 0; i < 5; i++) {
      setTimeout(() => {
        const firework = document.createElement('div');
        firework.className = 'firework';
        firework.style.left = `${10 + Math.random() * 80}vw`;
        firework.style.top = `${20 + Math.random() * 60}vh`;
        container.appendChild(firework);
        
        setTimeout(() => {
          firework.remove();
        }, 1000);
      }, i * 300);
    }
  }
  
  // Add this to your displayResults function (replace the existing one)
  function displayResults(result) {
      const resultContainer = document.getElementById('resultContainer');
      const resultAlert = document.getElementById('resultAlert');
      const resultTitle = document.getElementById('resultTitle');
      const resultMessage = document.getElementById('resultMessage');
      const improvementTips = document.getElementById('improvementTips');
      
      // Reset animations
      resultAlert.className = 'alert cosmic-alert';
      resultTitle.className = '';
      resultMessage.className = '';
      
      if (result.eligible) {
          resultAlert.classList.add('alert-success');
          resultTitle.textContent = 'Congratulations!';
          resultTitle.classList.add('gradient-text', 'glow', 'floating');
          resultMessage.innerHTML = `<p class="success-pulse">${result.message}</p><p>Our representative will contact you shortly.</p>`;
          improvementTips.innerHTML = '';
          
          // Add celebratory effects
          createConfetti();
          createFireworks();
          
          // Add cosmic celebration effect
          setTimeout(() => {
              const stars = document.querySelectorAll('#stars, #stars2, #stars3');
              stars.forEach(star => {
                  star.style.animationDuration = '20s';
              });
              setTimeout(() => {
                  stars.forEach(star => {
                      star.style.animationDuration = '';
                  });
              }, 2000);
          }, 500);
      } else {
          resultAlert.classList.add('alert-danger', 'error-shake');
          resultTitle.textContent = 'Eligibility Check Failed';
          resultTitle.classList.add('glow');
          resultMessage.innerHTML = `<p>${result.message}</p>`;
          
          let tipsHtml = '<h5 class="mt-3">To improve your eligibility:</h5><ul class="list-group mt-2">';
          result.improvementTips.forEach(tip => {
              tipsHtml += `<li class="list-group-item cosmic-input">${tip}</li>`;
          });
          tipsHtml += '</ul>';
          improvementTips.innerHTML = tipsHtml;
          
          // Add dramatic effect for failure
          setTimeout(() => {
              document.body.style.filter = 'brightness(0.8)';
              setTimeout(() => {
                  document.body.style.filter = '';
              }, 500);
          }, 0);
      }
      
      resultContainer.style.display = 'block';
  }
