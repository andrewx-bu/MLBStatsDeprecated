from flask import Flask, request, jsonify
import requests
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/sports_players', methods=['GET'])
def get_sports_players():
    ver = request.args.get('ver', 'v1')
    sportId = request.args.get('sportId')
    season = request.args.get('season')
    gameType = request.args.get('gameType', 'R')
    fields = request.args.get('fields', '')

    if not sportId or not season:
        return jsonify({'error': 'Missing required parameters'}), 400

    url = f"https://statsapi.mlb.com/api/{ver}/sports/{sportId}/players"
    params = {
        'season': season,
        'gameType': gameType,
        'fields': fields
    }

    response = requests.get(url, params=params)

    if response.status_code != 200:
        return jsonify({'error': 'Failed to fetch data from MLB API'}), response.status_code

    # Log the JSON response for debugging
    print(response.json())

    return jsonify(response.json())

if __name__ == '__main__':
    app.run(debug=True)
