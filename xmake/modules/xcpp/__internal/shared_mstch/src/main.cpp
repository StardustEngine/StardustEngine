#include <xmi.h>
#include <mustache.hpp>

#include <fstream>
#include <sstream>
#include <iostream>

using namespace kainjow;

static mustache::data __internalConvertLuaValue(lua_State* lua, int index);

static mustache::data __internalConvertLuaTable(lua_State* lua, int index)
{
    if (index < 0) {
        index = lua_gettop(lua) + index + 1;
    }

    // determine whether the table is an array
    bool is_array = true;
    lua_pushnil(lua);
    while (lua_next(lua, index) != 0) {
        if (lua_type(lua, -2) != LUA_TNUMBER) {
            is_array = false;
            lua_pop(lua, 2);
            break;
        } else {
            lua_pop(lua, 1);
        }
    }

    if (is_array) {
        mustache::data list_data(mustache::data::type::list);
        int len = lua_rawlen(lua, index);
        for (int i = 1; i <= len; ++i) {
            lua_rawgeti(lua, index, i);
            list_data << __internalConvertLuaValue(lua, -1);
            lua_pop(lua, 1);
        }
        return list_data;
    } else {
        mustache::data object_data;
        lua_pushnil(lua);
        while (lua_next(lua, index) != 0) {
            if (lua_type(lua, -2) == LUA_TSTRING) {
                object_data.set(lua_tostring(lua, -2), __internalConvertLuaValue(lua, -1));
            }
            lua_pop(lua, 1);
        }
        return object_data;
    }
}

static mustache::data __internalConvertLuaValue(lua_State* lua, int index)
{
    switch (lua_type(lua, index)) {
    case LUA_TSTRING:
        return mustache::data(lua_tostring(lua, index));
    case LUA_TNUMBER: {
        double num = lua_tonumber(lua, index);
        std::ostringstream oss;
        oss << num;
        return mustache::data(oss.str());
    }
    case LUA_TBOOLEAN:
        return mustache::data(lua_toboolean(lua, index) ? "true" : "false");
    case LUA_TTABLE:
        return __internalConvertLuaTable(lua, index);
    default:
        return mustache::data("");
    }
}

static int mstchRender(lua_State* lua)
{
    mustache::mustache mstch_object { lua_tostring(lua, 1) };
    lua_pushstring(lua, mstch_object.render(__internalConvertLuaValue(lua, 2)).c_str());
    return 1;
}

int luaopen(shared_mstch, lua_State* lua) {
    static const luaL_Reg funcs[] = {
        { "render", mstchRender },
        { NULL, NULL }
    };
    lua_newtable(lua);
    luaL_setfuncs(lua, funcs, 0);
    return 1;
}
