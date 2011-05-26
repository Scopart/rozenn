/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */package org.rozenn{    /**     * Defines the minimum set of levels recognized by the system, that is <code>OFF</code>, <code>FATAL</code>, <code>ERROR</code>, <code>WARN</code>, <code>INFO</code>, <code>DEBUG</code> and <code>ALL</code>.      *      * @author Alexis Couronne     */    public class Level    {        /**         * The <code>ALL</code> has the lowest possible rank and is intended to turn on all logging.         */        static public const ALL : Level = new Level(int.MIN_VALUE, "ALL", 0x666666);        /**         * The <code>DEBUG</code> Level designates fine-grained informational events that are most useful to debug an application.         */        static public const DEBUG : Level = new Level(10000, "DEBUG", 0x0086B3);        /**         * The <code>INFO</code> level designates informational messages that highlight the progress of the application at coarse-grained level.         */        static public const INFO : Level = new Level(20000, "INFO", 0x00B32D);        /**         * The <code>WARN</code> level designates potentially harmful situations.         */        static public const WARN : Level = new Level(30000, "WARN", 0xB38600);        /**         * The <code>ERROR</code> level designates error events that might still allow the application to continue running.         */        static public const ERROR : Level = new Level(40000, "ERROR", 0xB32D00);        /**         * The <code>FATAL</code> level designates very severe error events that will presumably lead the application to abort.         */        static public const FATAL : Level = new Level(50000, "FATAL", 0xB3002D);        /**         * The <code>OFF</code> has the highest possible rank and is intended to turn off logging.         */        static public const OFF : Level = new Level(int.MAX_VALUE, "OFF", 0);        /**         * Convert the string passed as argument to a level.         * If level not found <code>null</code> is returned.         *          * @param levelName level name         * @return level object or <code>null</code> if level not found.         */        static public function getLevel(levelName : String) : Level        {            levelName = levelName.toUpperCase();            switch(levelName)            {                case ALL.getName():                    return ALL;                case DEBUG.getName():                    return DEBUG;                case INFO.getName():                    return INFO;                case WARN.getName():                    return WARN;                case ERROR.getName():                    return ERROR;                case FATAL.getName():                    return FATAL;                case OFF.getName():                    return OFF;                default:                    return null;            }        }        /**         * @private         */        private var id : int;        /**         * @private         */        private var name : String;        /**         * @private         */        private var color : uint;        /**         * Instanciate <code>Level></code> object.         * @param id	Minimum level the log message has to be, to be compliant with this current <code>Level</code> filter.         * @param name  identifier for this level         * @param color color for this level         */        public function Level(id : int, name : String, color : uint)        {            this.id = id;            this.name = name;            this.color = color;        }        /**         * Returns the level filter value.         *          * @return The level filter value.         */        public function getID() : int        {            return id;        }        /**         * Returns the name of current level filter.         *          * @return The name of current level filter.         */        public function getName() : String        {            return name;        }        /**         * Returns the color of current level filter.         *          * @return The color of current level filter.         */        public function getColor() : uint        {            return color;        }        /**         * Returns the string representation of this instance.         *          * @return The string representation of this instance         */        public function toString() : String        {            return name;        }    }}