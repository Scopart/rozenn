/* * Copyright the original author or authors. *  * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at *  *      http://www.mozilla.org/MPL/MPL-1.1.html *  * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. * See the License for the specific language governing permissions and * limitations under the License. */package org.rozenn{    import flash.utils.Dictionary;    import flash.utils.getQualifiedClassName;    import org.rozenn.formatter.IFormatter;    /**     * This is the central class in the <code>logger</code> package. Most logging operations, except configuration, are done through this class.      *      * @author Alexis Couronne     */    public class Logger    {        /**         * @private         */        private var clazz : String;        /**         * @private         */        private var level : Level;        /**         * @private         */        private var parent : Logger;        /**         * @private         */        private static var loggers : Dictionary = new Dictionary(true);                /**         * @private         */        private static const ROOT_LOGGER_NAME : String = "root";        /**         *  Retrieve a logger named according to the value of the name parameter.         *  If the named logger already exists, then the existing instance will be returned. Otherwise, a new instance is created.         *  By default, loggers do not have a set level but inherit it from their neareast ancestor with a set level.         *           *  @param clazz The name or the name of clazz will be used as the name of the logger to retrieve.          *  @return Logger instance.         *  @throws 	<code>ArgumentError</code> - if <code>clazz</code> parameter is not a <code>Class</code> or <code>String</code> object         */        public static function getLogger(clazz : *) : Logger        {            if (clazz is Class)            {                clazz = getClassName(clazz);            }            else if (clazz is String)            {            }            else            {                throw new ArgumentError("class argument must be a Class or String");            }            if (loggers[clazz] != null)            {                return loggers[clazz];            }            else            {                loggers[clazz] = new Logger(clazz);                return loggers[clazz];            }        }                /**         * Returns the root logger         *          * @return Logger instance.         */        public static function getRootLogger() : Logger        {        	return getLogger(ROOT_LOGGER_NAME);        }        /**         * Build a <code>Logger</code> instance.         *          * @param clazz the name for this logger (<code>Class</code> or <code>String</code> object)         * @param the level for this logger.         * @throws 	<code>ArgumentError</code> - if <code>clazz</code> parameter is not a <code>Class</code> or <code>String</code> object         */        public function Logger(clazz : *, level : Level = null)        {            if (clazz is Class)            {                clazz = getClassName(clazz);            }            else if (clazz is String)            {            }            else            {                throw new ArgumentError("class argument must be a Class or String");            }            this.level = level;            this.clazz = clazz;            initParent();        }        /**         * Log a message object with passed-in level object.         *          * @param level	the level for this message.         * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function log(level : Level, message : *, formatter : IFormatter = null) : void        {            if (level.getID() >= getEffectiveLevel().getID())            {            	Rozenn.log(new LogRecord(this, level, message, formatter));            }        }        /**         * Log a message object with the <code>DEBUG</code> level.         *          * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function debug(message : *, formatter : IFormatter = null) : void        {            log(Level.DEBUG, message, formatter);        }        /**         * Log a message object with the <code>INFO</code> level.         *          * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function info(message : *, formatter : IFormatter = null) : void        {            log(Level.INFO, message, formatter);        }        /**         * Log a message object with the <code>WARN</code> level.         *          * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function warn(message : *, formatter : IFormatter = null) : void        {            log(Level.WARN, message, formatter);        }        /**         * Log a message object with the <code>ERROR</code> level.         *          * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function error(message : *, formatter : IFormatter = null) : void        {            log(Level.ERROR, message, formatter);        }        /**         * Log a message object with the <code>FATAL</code> level.         *          * @param message the message object to log.         * @param formatter the formatter for this message.         */        public function fatal(message : *, formatter : IFormatter = null) : void        {            log(Level.FATAL, message, formatter);        }        /**         * Log an <code>Error</code> stack trace with the <code>ERROR</code> level;         *          * @param error the error object to log         * @param formatter the formatter for this message         */        public function exception(error : Error, formatter : IFormatter = null) : void        {            log(Level.ERROR, error.getStackTrace(), formatter);        }        /**         * Return the logger name.          *          * @return the logger name         */        public function getClass() : String        {            return clazz;        }        /**         * Starting from this logger, search the logger hierarchy for a non-null level and return it.          * Otherwise, return the level of the root logger.          *          * @return the logger hierarchy level         */        public function getEffectiveLevel() : Level        {            var logger : Logger = this;            while (logger != null)            {                if (logger.level != null)                {                    return logger.level;                }                logger = logger.parent;            }            return Level.ALL;        }        /**         * Set the level of this logger.         * Null values are admitted.          *          * @param level          */        public function setLevel(level : Level) : void        {            this.level = level;        }        /**         * Returns the string representation of <code>Logger</code>         *          * @return the string representation of <code>Logger</code>         */        public function toString() : String        {            return clazz;        }        /**         * @private         */        private function setParent(parent : Logger) : void        {            this.parent = parent;        }        /**         * @private         */        private function initParent() : void        {            if (clazz != ROOT_LOGGER_NAME)            {                var a : Array = clazz.split(".");                var logger : Logger = Logger.getLogger(ROOT_LOGGER_NAME);                var pkg : String = "";                for each (var s : String in a)                {                    pkg += s;                    if (pkg != clazz)                    {                        Logger.getLogger(pkg).setParent(logger);                        logger = Logger.getLogger(pkg);                    }                    else                    {                        parent = logger;                    }                    pkg += ".";                }            }        }        /**         * @private         */        private static function getClassName(object : Object) : String        {            return getQualifiedClassName(object).replace("::", ".");        }    }}