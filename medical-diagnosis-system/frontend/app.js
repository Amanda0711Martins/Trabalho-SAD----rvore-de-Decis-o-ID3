document.addEventListener("DOMContentLoaded", function() {
    const tableBody = document.getElementById("symptom-table-body");
    const diagnoseButton = document.getElementById("diagnose-button");
    const resultText = document.getElementById("diagnosis-result");

    const symptomsList = ["Dores de cabeça", "Dores no peito", "Dores nos olhos", "Nariz escorrendo"];
    const intensityLevels = ["Irrelevante", "Médio", "Forte"];

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
        const selectedSymptoms = {};
        document.querySelectorAll("#symptom-table-body tr").forEach(row => {
            const symptom = row.cells[0].textContent;
            const intensity = row.cells[1].querySelector("select").value;
            selectedSymptoms[symptom] = intensity;
        });

        try {
            const response = await fetch("http://127.0.0.1:5000/diagnosis", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ symptoms: selectedSymptoms })
            });

            if (!response.ok) throw new Error("Erro ao se conectar com o servidor!");

            const data = await response.json();
            resultText.textContent = `Diagnóstico: ${data.diagnosis}`;
        } catch (error) {
            resultText.textContent = "Erro ao obter diagnóstico.";
        }
    });
});
