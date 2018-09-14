"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var Buffer_1 = require("./Buffer");
var BufferLine = (function () {
    function BufferLine(cols, ch, isWrapped) {
        this.isWrapped = false;
        this._data = [];
        this.length = this._data.length;
        if (cols) {
            if (!ch) {
                ch = [0, Buffer_1.NULL_CELL_CHAR, Buffer_1.NULL_CELL_WIDTH, Buffer_1.NULL_CELL_CODE];
            }
            for (var i = 0; i < cols; i++) {
                this.push(ch);
            }
        }
        if (isWrapped) {
            this.isWrapped = true;
        }
    }
    BufferLine.blankLine = function (cols, attr, isWrapped) {
        var ch = [attr, Buffer_1.NULL_CELL_CHAR, Buffer_1.NULL_CELL_WIDTH, Buffer_1.NULL_CELL_CODE];
        return new BufferLine(cols, ch, isWrapped);
    };
    BufferLine.prototype.get = function (index) {
        return this._data[index];
    };
    BufferLine.prototype.set = function (index, data) {
        this._data[index] = data;
    };
    BufferLine.prototype.pop = function () {
        var data = this._data.pop();
        this.length = this._data.length;
        return data;
    };
    BufferLine.prototype.push = function (data) {
        this._data.push(data);
        this.length = this._data.length;
    };
    BufferLine.prototype.splice = function (start, deleteCount) {
        var items = [];
        for (var _i = 2; _i < arguments.length; _i++) {
            items[_i - 2] = arguments[_i];
        }
        var removed = (_a = this._data).splice.apply(_a, [start, deleteCount].concat(items));
        this.length = this._data.length;
        return removed;
        var _a;
    };
    BufferLine.prototype.insertCells = function (pos, n, ch) {
        while (n--) {
            this.splice(pos, 0, ch);
            this.pop();
        }
    };
    BufferLine.prototype.deleteCells = function (pos, n, fill) {
        while (n--) {
            this.splice(pos, 1);
            this.push(fill);
        }
    };
    BufferLine.prototype.replaceCells = function (start, end, fill) {
        while (start < end && start < this.length) {
            this.set(start++, fill);
        }
    };
    return BufferLine;
}());
exports.BufferLine = BufferLine;
//# sourceMappingURL=BufferLine.js.map