/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.db.instance.configs.migrations

import io.github.oshai.kotlinlogging.KotlinLogging
import org.flywaydb.core.api.migration.BaseJavaMigration
import org.flywaydb.core.api.migration.Context
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.jooq.impl.SQLDataType

private val log = KotlinLogging.logger {}

/**
 * Add log_all_http_calls column to connection table for comprehensive HTTP/HTTPS request debugging.
 * This feature allows users to enable detailed logging of all HTTP API calls including sensitive data
 * like headers, authentication details, request/response bodies, and pagination tokens.
 */
@Suppress("ktlint:standard:class-naming")
class V1_6_0_020__AddLogAllHttpCallsToConnection : BaseJavaMigration() {
  override fun migrate(context: Context) {
    log.info { "Running migration: ${javaClass.simpleName}" }

    // Warning: please do not use any jOOQ generated code to write a migration.
    // As database schema changes, the generated jOOQ code can be deprecated. So
    // old migration may not compile if there is any generated code.
    val ctx: DSLContext = DSL.using(context.connection)
    addLogAllHttpCallsColumn(ctx)
  }

  companion object {
    private const val CONNECTION_TABLE = "connection"
    private const val LOG_ALL_HTTP_CALLS_COLUMN = "log_all_http_calls"

    /**
     * Adds the log_all_http_calls column to the connection table.
     * Defaults to FALSE for production safety.
     *
     * @param ctx the DSL context for database operations
     */
    fun addLogAllHttpCallsColumn(ctx: DSLContext) {
      val connectionTable = DSL.table(CONNECTION_TABLE)
      val logAllHttpCallsColumn = DSL.field(LOG_ALL_HTTP_CALLS_COLUMN, SQLDataType.BOOLEAN.nullable(false).defaultValue(false))

      ctx
        .alterTable(connectionTable)
        .addColumnIfNotExists(logAllHttpCallsColumn)
        .execute()

      log.info { "Successfully added $LOG_ALL_HTTP_CALLS_COLUMN column to $CONNECTION_TABLE table with default value FALSE" }
    }
  }
}