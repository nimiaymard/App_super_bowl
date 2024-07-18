
document.addEventListener("DOMContentLoaded", function() {
    fetch('http://localhost/projet-superbowl/backend/all-matches.php')
        .then(response => {
            if (!response.ok) {
                throw new Error('La réponse réseau n\'était pas correcte');
            }
            return response.json();
        })
        .then(data => {
            const matchesContainer = document.getElementById('all-matches');
            if (data.matches && data.matches.length > 0) {
                data.matches.forEach(match => {
                    const matchElement = document.createElement('div');
                    matchElement.className = 'match';
                    matchElement.innerHTML = `
                        <h3>${match.team1} vs ${match.team2}</h3>
                        <p>Date : ${match.date}</p>
                        <p>Heure : ${match.time}</p>
                        <p>Statut : ${match.status}</p>
                        <p>Météo : ${match.weather}</p>
                        <button onclick="viewMatchDetails(${match.id})">Voir les détails</button>
                    `;
                    matchesContainer.appendChild(matchElement);
                });
            } else {
                matchesContainer.innerHTML = '<p>Aucun match disponible.</p>';
            }
        })
        .catch(error => {
            console.error('Erreur lors de la récupération des matchs:', error);
            document.getElementById('all-matches').innerHTML = '<p>Erreur lors de la récupération des matchs.</p>';
        });
});

function viewMatchDetails(matchId) {
    window.location.href = `match-details.html?match_id=${matchId}`;
}
