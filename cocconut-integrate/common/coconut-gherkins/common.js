const AsciiTable = require('ascii-table');
const fs = require('fs');
const path = require('path');
const { DataTable } = require('@cucumber/cucumber');

const DATA_ROOT = path.join(__dirname, '../features/testData');

const deleteLines = (string, n = 1)=>{
    return string.split('\n').filter((v, i) => i !== n).join('\n');

};

function readTestData(filePath) {
    const nicePath = path.join(DATA_ROOT, filePath);
    const content = fs.readFileSync(nicePath, 'utf-8');
    return JSON.parse(content);
}

function renderTable(heading,rows) {
    var table = AsciiTable.factory({
        heading,
        rows 
      });
    table.setBorder(['|'], [], [], [])
        .setHeadingAlign(AsciiTable.LEFT);
    const tableStr = table.toString();
    const tablePrettied = deleteLines(tableStr, 2);
    return tablePrettied;
}

function addComments(str) {
    return str.split('\n').map(line => `# ${line}`).join('\n');
}

function parseTable(content) {
    const lines = content.split('\n').map(l => l.trim());
    const validLines = lines.filter(l => l.startsWith('|'));
    const rows = validLines.map(row => {
        const cells = row.split('|').map(cell => cell.trim());
        cells.pop();
        cells.shift();
        return cells;
    });
    const table = new DataTable(rows);
    let rowsHash = [];
    try{
        rowsHash = table.rowsHash();
    } catch(e) {
        // DO NOTHING
    }
    return {
        raw: table.raw(),
        hashes: table.hashes(),
        rows: table.rows(),
        rowsHash
    }
}

module.exports = {
    renderTable,
    readTestData,
    addComments,
    parseTable,
}