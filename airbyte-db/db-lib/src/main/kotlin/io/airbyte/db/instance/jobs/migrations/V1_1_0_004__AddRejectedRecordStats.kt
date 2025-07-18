/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.db.instance.jobs.migrations

import io.github.oshai.kotlinlogging.KotlinLogging
import org.flywaydb.core.api.migration.BaseJavaMigration
import org.flywaydb.core.api.migration.Context
import org.jooq.DSLContext
import org.jooq.impl.DSL
import org.jooq.impl.SQLDataType

private val log = KotlinLogging.logger {}

@Suppress("ktlint:standard:class-naming")
class V1_1_0_004__AddRejectedRecordStats : BaseJavaMigration() {
  override fun migrate(context: Context) {
    log.info { "Running migration: ${javaClass.simpleName}" }

    // Warning: please do not use any jOOQ generated code to write a migration.
    // As database schema changes, the generated jOOQ code can be deprecated. So
    // old migration may not compile if there is any generated code.
    val ctx: DSLContext = DSL.using(context.connection)
    updateStreamStats(ctx)
    updateSyncStats(ctx)
  }

  private fun updateStreamStats(ctx: DSLContext) {
    val streamStats = "stream_stats"
    ctx
      .alterTable(streamStats)
      .addColumnIfNotExists(DSL.field("records_rejected", SQLDataType.BIGINT.nullable(true)))
      .execute()
  }

  private fun updateSyncStats(ctx: DSLContext) {
    val streamStats = "sync_stats"
    ctx
      .alterTable(streamStats)
      .addColumnIfNotExists(DSL.field("records_rejected", SQLDataType.BIGINT.nullable(true)))
      .execute()
  }
}
