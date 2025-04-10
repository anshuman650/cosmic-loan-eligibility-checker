#!/bin/bash

# Create all files with their content
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cosmic Loan Eligibility Checker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --bg-color: #000;
            --text-color: #fff;
            --card-bg: rgba(30, 30, 40, 0.85);
            --card-border: #444;
            --header-bg: linear-gradient(135deg, #3a3a5a 0%, #1a1a2a 100%);
            --input-bg: rgba(20, 20, 30, 0.8);
            --input-border: #555;
        }

        .light-mode {
            --bg-color: #f8f9fa;
            --text-color: #212529;
            --card-bg: rgba(255, 255, 255, 0.95);
            --card-border: #ddd;
            --header-bg: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);
            --input-bg: rgba(255, 255, 255, 0.9);
            --input-border: #ced4da;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="mode-toggle-container">
        <button id="modeToggle" class="btn btn-sm mode-toggle-btn">
            <i class="bi bi-moon-fill"></i> Dark Mode
        </button>
    </div>

    <div id="stars"></div>
    <div id="stars2"></div>
    <div id="stars3"></div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card cosmic-card">
                    <div class="card-header cosmic-header">
                        <h3 class="text-center mb-0">Cosmic Loan Eligibility Checker</h3>
                        <div class="cosmic-subtitle">India's Most Advanced Loan Analyzer</div>
                    </div>
                    <div class="card-body p-4">
                        <form id="loanForm">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label cosmic-label">Full Name</label>
                                    <input type="text" class="form-control cosmic-input" id="name" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="age" class="form-label cosmic-label">Age</label>
                                    <input type="number" class="form-control cosmic-input" id="age" min="18" max="75" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="income" class="form-label cosmic-label">Monthly Income (₹)</label>
                                    <input type="number" class="form-control cosmic-input" id="income" min="10000" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="loanAmount" class="form-label cosmic-label">Loan Amount (₹)</label>
                                    <input type="number" class="form-control cosmic-input" id="loanAmount" min="10000" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="employment" class="form-label cosmic-label">Employment Type</label>
                                    <select class="form-select cosmic-input" id="employment" required>
                                        <option value="">Select</option>
                                        <option value="salaried">Salaried</option>
                                        <option value="self-employed">Self-Employed</option>
                                        <option value="business">Business Owner</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="creditScore" class="form-label cosmic-label">Credit Score (300-900)</label>
                                    <input type="number" class="form-control cosmic-input" id="creditScore" min="300" max="900">
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <button type="submit" class="btn cosmic-btn btn-lg px-5">
                                    <span class="btn-text">Check Eligibility</span>
                                    <span class="btn-spinner" style="display:none;">
                                        <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                    </span>
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4" id="loader" style="display:none;">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <p class="mt-2">Analyzing your application...</p>
                        </div>

                        <div class="result-container mt-4" id="resultContainer" style="display:none;">
                            <div class="alert cosmic-alert" id="resultAlert">
                                <h4 class="alert-heading" id="resultTitle"></h4>
                                <div id="resultMessage"></div>
                            </div>
                            <div class="mt-3" id="improvementTips"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>
</html>
EOF

cat > style.css << 'EOF'
/* Base Styles */
html, body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    overflow-x: hidden;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Mode Toggle Button */
.mode-toggle-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
}

.mode-toggle-btn {
    background-color: var(--card-bg);
    color: var(--text-color);
    border: 1px solid var(--card-border);
    border-radius: 20px;
    padding: 5px 15px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.mode-toggle-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

/* Animated Stars (Dark Mode Only) */
#stars, #stars2, #stars3 {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    display: block;
    z-index: -1;
    opacity: 1;
    transition: opacity 0.5s ease;
}

.light-mode #stars,
.light-mode #stars2,
.light-mode #stars3 {
    opacity: 0;
}

#stars {
    background: transparent url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="20" cy="20" r="0.5" fill="white"/><circle cx="50" cy="50" r="0.5" fill="white"/><circle cx="80" cy="30" r="0.5" fill="white"/><circle cx="30" cy="80" r="0.5" fill="white"/><circle cx="70" cy="70" r="0.5" fill="white"/></svg>') repeat top center;
    animation: moveStars 200s linear infinite;
}

#stars2 {
    background: transparent url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="10" cy="10" r="0.7" fill="white"/><circle cx="90" cy="10" r="0.7" fill="white"/><circle cx="50" cy="90" r="0.7" fill="white"/><circle cx="20" cy="60" r="0.7" fill="white"/><circle cx="80" cy="60" r="0.7" fill="white"/></svg>') repeat top center;
    animation: moveStars 150s linear infinite;
    opacity: 0.7;
}

#stars3 {
    background: transparent url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="150" height="150" viewBox="0 0 150 150"><circle cx="75" cy="25" r="1" fill="white"/><circle cx="25" cy="75" r="1" fill="white"/><circle cx="125" cy="75" r="1" fill="white"/><circle cx="75" cy="125" r="1" fill="white"/></svg>') repeat top center;
    animation: moveStars 100s linear infinite;
    opacity: 0.5;
}

@keyframes moveStars {
    0% { background-position: 0 0; }
    100% { background-position: 1000px 1000px; }
}

/* Card Styling */
.cosmic-card {
    background-color: var(--card-bg) !important;
    border: 1px solid var(--card-border) !important;
    border-radius: 15px !important;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1) !important;
    backdrop-filter: blur(5px);
    transition: all 0.3s ease;
}

.cosmic-header {
    background: var(--header-bg) !important;
    color: #fff !important;
    border-radius: 15px 15px 0 0 !important;
    border-bottom: 1px solid var(--card-border) !important;
}

.cosmic-subtitle {
    font-size: 0.9rem;
    opacity: 0.8;
    text-align: center;
    margin-top: 5px;
}

/* Form Elements */
.cosmic-label {
    color: var(--text-color) !important;
}

.cosmic-input {
    background-color: var(--input-bg) !important;
    border: 1px solid var(--input-border) !important;
    color: var(--text-color) !important;
    transition: all 0.3s ease;
}

.cosmic-input:focus {
    background-color: var(--input-bg) !important;
    border-color: #6B73FF !important;
    box-shadow: 0 0 10px rgba(107, 115, 255, 0.5) !important;
    color: var(--text-color) !important;
}

.cosmic-btn {
    background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%) !important;
    border: none !important;
    color: white !important;
    box-shadow: 0 0 15px rgba(107, 115, 255, 0.5) !important;
    transition: all 0.3s ease !important;
}

.cosmic-btn:hover {
    transform: translateY(-2px) !important;
    box-shadow: 0 0 20px rgba(107, 115, 255, 0.8) !important;
}

/* Results Styling */
.cosmic-alert {
    background-color: var(--card-bg) !important;
    border: 1px solid var(--card-border) !important;
    color: var(--text-color) !important;
}

/* Make sure content is above stars */
.container {
    position: relative;
    z-index: 1;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .cosmic-card {
        margin: 15px;
    }
    
    .mode-toggle-container {
        top: 10px;
        right: 10px;
    }
}
EOF

cat > script.js << 'EOF'
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
EOF

cat > server.py << 'EOF'
import http.server
import socketserver

PORT = 8000

Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving at http://localhost:{PORT}")
    httpd.serve_forever()
EOF

cat > README.md << 'EOF'
# Cosmic Loan Eligibility Checker

A space-themed loan eligibility checker with dark/light mode toggle.

## Features

- Toggle between dark and light modes
- Animated star background in dark mode
- Responsive design
- Gemini API integration
- Mode preference saved in local storage

## How to Run

1. Make the script executable:
   ```bash
   chmod +x setup.sh
   ./setup.sh