using System.Data.SqlClient;

namespace enerser.analytics.Utils
{
    public static class SqlExtensions
    {
        public static T GetValue<T>(this SqlDataReader reader, string columnName, T defaultValue)
        {
            int ordinal = reader.GetOrdinal(columnName);
            if (reader.IsDBNull(ordinal))
            {
                return defaultValue;
            }
            object value = reader.GetValue(ordinal);
            try
            {
                if (typeof(T) == typeof(int))
                    return (T)(object)Convert.ToInt32(value);
                if (typeof(T) == typeof(double))
                    return (T)(object)Convert.ToDouble(value);
                if (typeof(T) == typeof(bool))
                    return (T)(object)Convert.ToBoolean(value);
                if (typeof(T) == typeof(DateTime))
                    return (T)(object)Convert.ToDateTime(value);
                return (T)Convert.ChangeType(value, typeof(T));
            }
            catch
            {
                return defaultValue;
            }
        }

        public static void AddWithNullableValue<T>(this SqlParameterCollection parameters, string parameterName, T value)
        {
            if (value == null || (typeof(T) == typeof(string) && string.IsNullOrWhiteSpace(value as string)))
            {
                parameters.AddWithValue(parameterName, DBNull.Value);
            }
            else if (typeof(T) == typeof(int) && (int)(object)value == 0)
            {
                parameters.AddWithValue(parameterName, DBNull.Value);
            }
            else if (typeof(T) == typeof(DateTime) && (DateTime)(object)value == default(DateTime))
            {
                parameters.AddWithValue(parameterName, DBNull.Value);
            }
            else
            {
                parameters.AddWithValue(parameterName, value);
            }
        }
    }
}
