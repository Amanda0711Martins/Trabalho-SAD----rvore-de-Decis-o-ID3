const symptomsList = [
    "Dores de cabeça", "Dores no peito", "Dores nos olhos", "Nariz escorrendo", "Dores no estômago",
    "Tosse", "Espirros", "Dor de garganta", "Palpitações", "Soluços",
    "Diarreia", "Náusea", "Dormência", "Insônia", "Desmaio", "Perda de olfato"
];

const intensityLevels = ["Irrelevante", "Médio", "Forte"];

document.addEventListener("DOMContentLoaded", function() {
    const tableBody = document.getElementById("symptom-table-body");
    const diagnoseButton = document.getElementById("diagnose-button");
    const resultText = document.getElementById("diagnosis-result");

    symptomsList.forEach(symptom => {
        const row = document.createElement("tr");
        const symptomCell = document.createElement("td");
        symptomCell.textContent = symptom;

        const intensityCell = document.createElement("td");
        const select = document.createElement("select");
        intensityLevels.forEach(level => {
            const option = document.createElement("option");
            option.value = level;
            option.textContent = level;
            select.appendChild(option);
        });
        intensityCell.appendChild(select);

        row.appendChild(symptomCell);
        row.appendChild(intensityCell);
        tableBody.appendChild(row);
    });

    diagnoseButton.addEventListener("click", async function() {
        const selectedSymptoms = [];
        document.querySelectorAll("#symptom-table-body tr").forEach(row => {
            const symptom = row.cells[0].textContent;
            const intensity = row.cells[1].querySelector("select").value;
            selectedSymptoms.push({ symptom, intensity });
        });

        const response = await fetch("http://localhost:5000/diagnosis", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ symptoms: selectedSymptoms })
        });

        const data = await response.json();
        resultText.textContent = `Diagnóstico: ${data.diagnosis}`;
    });
});
