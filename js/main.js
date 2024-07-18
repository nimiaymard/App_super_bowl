document.addEventListener("DOMContentLoaded", function () {
    fetch('../backend/index.php')
        .then(response => response.json())
        .then(data => {
            const matchesList = document.getElementById('matches-list');
            data.matches.forEach(match => {
                const matchElement = document.createElement('div');
                matchElement.className = 'match';
                matchElement.innerHTML = `
                    <h3>${match.team1} vs ${match.team2}</h3>
                    <p>Heure : ${match.time}</p>
                    <p>Statut : ${match.status}</p>
                `;
                matchesList.appendChild(matchElement);
            });
        })
        .catch(error => console.error('Erreur lors de la récupération des matchs :', error));
});
