API calls
@app.route('/0.2.1b/meals/create', methods=['POST'])
name = request.form['name']


@app.route('/0.2.1b/meals/<mealId>', methods=['DELETE'])
@app.route('/0.2.1b/meals/<mealId>', methods=['GET'])
@app.route('/0.2.1b/meals/<mealId>/user/<userId>', methods=['POST'])
@app.route('/0.2.1b/meals/<mealId>/user/<userId>', methods=['DELETE'])
@app.route('/0.2.1b/meals/<mealId>/user/<userId>', methods=['PUT'])


@app.route('/0.2.1b/meals/search/<float:latitude>/<float:longitude>', methods=['GET'])
@app.route('/0.2.1b/rating/host/<uhostID>', methods=['POST'])
@app.route('/0.2.1b/rating/host/average/<uhostID>', methods=['GET'])
@app.route('/0.2.1b/rating/guest/<userId>', methods=['POST'])
@app.route('/0.2.1b/rating/guest/average/<userId>', methods=['GET'])
@app.route('/0.2.1b/user/<userId>/information', methods=['GET'])
@app.route('/0.2.1b/user/<userId>/information', methods=['PUT'])

