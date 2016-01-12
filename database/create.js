var fs = require('fs');

var createDbSchema = [
    'database/schema/meta_data.sql',
    'database/schema/actual_data.sql',
    'database/schema/users_data.sql',
    'database/schema/relations.sql',
    'database/schema/views.sql',
].map(function (filename) {
    return fs.readFileSync(filename).toString('utf-8');
}).join('\n\n');

module.exports = createDbSchema;
